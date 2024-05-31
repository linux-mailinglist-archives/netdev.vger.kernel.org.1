Return-Path: <netdev+bounces-99868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 314A38D6CBE
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 01:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63A531C25735
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 23:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C8B8405D;
	Fri, 31 May 2024 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="y3Q6p33F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C168287C
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717196840; cv=none; b=cOpnSmegmcg08meS+47bAXrux7H3HGhqnEYRnwprktoE7xdtJ+bgG7Vi3Xh0692nAohkT0OueyXNk5W1J/voYsLoC1ICSENbhg11s8F/+EAbX9XXOMEgAJLt1UZ4pIkq+bqaVxyDkrhE2oANkzSuHDr7U2gFJNlsMVF8OC16ryQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717196840; c=relaxed/simple;
	bh=cctJ94fMntMdvxYERD0SH2y3LWF1uah6MsouxBGOJsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DMj9fjX34+W97uOux+tDa4xEnmjldLbenohbxh7YkUsfrACv63G5s3ZAcRWYYU+NVM+AMvqM7QTSdPc9B+Dp2GQOiYplod8gMEa8BCyqW1oKwriWNaKhh4JHJl6vSUpnR612vz65HcEdRNZ1bdpKnb5ARpNkW8iVh7SlrNlLv1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=y3Q6p33F; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b96a587d79so374481eaf.0
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 16:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1717196837; x=1717801637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hNdEx2WEhN5SVP64QgU+uDtmVlp7EAxiArmrdD7iWNU=;
        b=y3Q6p33Fwe414fbBrLYRJrKLiOUFLvKhJS8hG0VX5JnmeWYO+iqe5SdQTyRsZtyyFa
         R4UCnLpLWv5xA/KHn0jItMAyBMle9SDq3MyLudtNErq42AnLP7rGQV457ojkQVI8ZLiR
         kH/8mSIwTi5Dj64YcLM98hAl7XQS2AMVufMyFN7Yx+ck+trprUrY3Ssre+qfHhKQ/pEO
         nPBsHvdGfXhmDkWFkbZsr8eySdz6GV2Slk45ZqDuWgjdeIJvsb8GgD2jwXKN3sVw/c35
         Y9vZcDryBpTU/LUIW7wErj3Ptpbkk/6V5BAzjTetxSZzPPgxc9XOeWk0HVK+0Bx9TvXK
         /G6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717196837; x=1717801637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hNdEx2WEhN5SVP64QgU+uDtmVlp7EAxiArmrdD7iWNU=;
        b=LxzMJkDBkOx/kK2nQA2waj3tsz08TeXKFwvUB4T8aWsbsppQlOtDnu6AVNc/q2/sa8
         PiGdRN1E9XM1DxvL0KofMQzHJbiyh6sL5/zN56tDWLI+/1fhm+1C5xeyKeeww4zNC5lN
         fGsYpfTb1Pp8H0GkQdDjUp+3+M5FqHYlqke+Mpi1Go1Fh4shVvg+cnOzh3vKNgxnQFI6
         9ylpZnUNdl8WXVCC9DmLPrcPVdiH/1GR1EMLmLg6TdCtxJASpK6lFVJHAFWgz5F1LBcM
         wpTYmv7VeI3R2hR9f2hFRDwtI70yzIjI6hZbBAUbwZEApvHUFz43dMOyqfqk3+dEZ1On
         JSRA==
X-Forwarded-Encrypted: i=1; AJvYcCVYIY+tA+1paSEWHimqyZQR1980VCTaBYsajMdSIagSCwCadOOqx+pSlrhRP+MzvpA8g1ndqrvQwoj7g9YxkVVhAiTkGXIK
X-Gm-Message-State: AOJu0YyF5T31bDR3rQQfpUkF1o2+8Fcbw8EQrDRFKYtzgW5RLcRa8P27
	teTqxpp0V+tiRmLaMYDd/lBKoBxQfMNREcrJ3lFA7cumU6HvpZgAJcIft4awrDJhd9Wsf+mM4H2
	5
X-Google-Smtp-Source: AGHT+IHCfR7NCpM6YaqjSTLZgnX8dkcEXfADEz3F2fTLZyqslpNUzYoJ0XICHoXIoPqkZADzwIGgag==
X-Received: by 2002:a05:6358:2803:b0:199:432b:8216 with SMTP id e5c5f4694b2df-19b482c845cmr353119855d.0.1717196837198;
        Fri, 31 May 2024 16:07:17 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c359848a32sm1727252a12.69.2024.05.31.16.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 16:07:16 -0700 (PDT)
Message-ID: <31ae884f-9db9-47ff-b32f-f870386ba9f8@kernel.dk>
Date: Fri, 31 May 2024 17:07:15 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] io_uring: Fix leak of async data when connect prep
 fails
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org
References: <20240531211211.12628-1-krisman@suse.de>
 <20240531211211.12628-2-krisman@suse.de>
 <d071a3f8-c4af-48ef-adae-385ea8705377@kernel.dk>
 <87ttidmvr4.fsf@mailhost.krisman.be>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87ttidmvr4.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/31/24 5:01 PM, Gabriel Krisman Bertazi wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 5/31/24 3:12 PM, Gabriel Krisman Bertazi wrote:
>>> move_addr_to_kernel can fail, like if the user provides a bad sockaddr
>>> pointer. In this case where the failure happens on ->prep() we don't
>>> have a chance to clean the request later, so handle it here.
>>
>> Hmm, that should still get freed in the cleanup path? It'll eventually
>> go on the compl_reqs list, and it has REQ_F_ASYNC_DATA set. Yes it'll
>> be slower than the recycling it, but that should not matter as it's
>> an erred request.
> 
> Hm right.  I actually managed to reproduce some kind of memory
> exhaustion yesterday that I thought was fixed by this patch.  But I see
> your point and I'm failing to trigger it today.
> 
> Please disregard this patch. I'll look further to figure out what I did
> there.

Maybe enable KMEMLEAK? It's pretty handy for testing. If there is a leak
there, you should be able to reliably get info by doing:

# ./reproducer (should be easy, just bogus addr)
# echo scan > /sys/kernel/debug/kmemleak
# sleep 5
# echo scan > /sys/kernel/debug/kmemleak

-- 
Jens Axboe


