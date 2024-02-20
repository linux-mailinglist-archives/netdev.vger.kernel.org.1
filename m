Return-Path: <netdev+bounces-73135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B525B85B192
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 04:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88FA4B20987
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 03:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4502B4643B;
	Tue, 20 Feb 2024 03:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="xL56PSfV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA3645942
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 03:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708400548; cv=none; b=M1NNDQmPdTjeJtxR1J0uM5ZjTLdpjYIOcMJ6+K143pXySNmRDD3F09gl0CbSJwI5QsL6TWDv06r63qI3nLsOxOfvYYb4foGja+VW35Dh2uY749+9q5lMllcihrw4AWbdpR+bosqOv69SuzJhnwwMyYLS/NEyRpu2wN90gwh1eoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708400548; c=relaxed/simple;
	bh=XkK5+xsHk6H8eyXdHQ0kV4WJkv1adLUjn5SDdv4QCA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9hpyWmnSbZBFAtHzbn18J/kac4OKMgrd0Xs53XRsqyoPYjjg4gwYB2NwlZByOnbwNE71dGtSHbN3xKU/4CpcYwGo8XHm3HtNiBargIw2ZECylVfCyiJwzORLgW3/500NTUy5EVgQ1Ojf2jbXY+2a3UJwTZguKN57nDPeZssYas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=xL56PSfV; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3651d6dea15so7505905ab.1
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 19:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1708400546; x=1709005346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AB6rD/0jKj/cDTVPdDWqZo49Ot7Kh6oQ/Xq9wSghJtY=;
        b=xL56PSfV4GkxtXYxPYnDlZZGvJkdxDvRXwEir6KfIKnCIc959ObjMgcyu6hW1Up7qh
         T7ViLIrY9dI8SBlO6+ESEVDD/1Tnpf2/niMVDrLjZ8dJYDIummbFbUsEbuMFdqiWzy0G
         mBPtU+KpWgpa7a4HoR8+iu0Lx2qrnPFuVJ9qljowgv0Q2NbEV74zwvqrvDPPn4o69QJp
         MdAxnlYdHSg7VFNrYNQD0Rqo5LSIu89vIiYaMDvTC2E+Cg/k2EhLm98ox7wWPnynirJt
         h689Aqxld8M9Y8zW3P11Dr2C8IysXnC/iJs6KHGlDihzuFSxFoMVzvj8udLcBnIwjnAl
         qiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708400546; x=1709005346;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AB6rD/0jKj/cDTVPdDWqZo49Ot7Kh6oQ/Xq9wSghJtY=;
        b=Y8gDvMbviQzyGVH+qQIkrfAPpX4S0UpWhq5eSrx3jSI0oKWi0bC+5u7ADOCGrPvh6+
         /yNHVxIpuXDqiJnZrVnu/leZZ1HRlLi9H+L454JBwF+Bd+rkfEZG1gGxeXNEqhBve0kN
         9l8LOHgGgv0eMK9DnILM5DUP3xooNFGiOxiTP2M7hr6KMijCsvVRZInD6QpU+vP92zIH
         ZbTgTcgArCoeq4ghxI08lrNPQoBmnLPPM/Kn+L+pqfRiA9s2rhUtbwij2cp8+VzUy2Hh
         nu3fbQl/owQvWOvOy1rRgoVA6soECsFIR+AfqOsGJqiTZZPkRBBBVF7QAkskyOrjgj1u
         HCQg==
X-Forwarded-Encrypted: i=1; AJvYcCXrslhhqU0I6fKWSa748Gn8u4da3KEn9FRzNXb2/KzjYlXpkQmqFhMDJbCOV3Ot2nVR/RPFfZ631FiJHRV0vCoQ7cSEZX8Q
X-Gm-Message-State: AOJu0Yzns27fMdV4dBHFDIhoBC9cdJeRNc3sXV/wuPEGN2FECwk9LdfD
	mRJSrStNyDgkH/5Z5FgsQxqZis7X0vQK5gpTePY+0PtHfvhUpiXB/jrE7UJZMQw=
X-Google-Smtp-Source: AGHT+IH38PG7DNyJIBI+Fr4JwKsTRi1vB94Zwwu7sHDoRkEOmoa0hOuq30h757Zt9cO07h/KxHyw1Q==
X-Received: by 2002:a05:6e02:1d9a:b0:365:2445:ffd6 with SMTP id h26-20020a056e021d9a00b003652445ffd6mr4622518ila.13.1708400545763;
        Mon, 19 Feb 2024 19:42:25 -0800 (PST)
Received: from [10.21.162.165] ([65.132.165.43])
        by smtp.gmail.com with ESMTPSA id r15-20020a056e02108f00b00364187af517sm2567501ilj.80.2024.02.19.19.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 19:42:25 -0800 (PST)
Message-ID: <f10f6de3-c61d-4f85-b18c-250fc4223ccd@davidwei.uk>
Date: Mon, 19 Feb 2024 20:42:17 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 0/3] netdevsim: link and forward skbs between
 ports
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <20240215194325.1364466-1-dw@davidwei.uk>
 <ea379c684c8dbab360dce3e9add3b3a33a00143f.camel@redhat.com>
 <cf9e07d6-6693-4511-93a6-e375d6f0e738@davidwei.uk>
 <20240216174859.7e65c1bf@kernel.org>
 <1bfeac24-73f3-4e9b-96e4-b9354be27285@davidwei.uk>
 <20240219112044.550ac583@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240219112044.550ac583@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-19 12:20, Jakub Kicinski wrote:
> On Fri, 16 Feb 2024 20:27:09 -0700 David Wei wrote:
>> On 2024-02-16 18:48, Jakub Kicinski wrote:
>>> Also looks like the new test managed to flake once while it was sitting
>>> in patchwork ?
>>>
>>> https://netdev-3.bots.linux.dev/vmksft-netdevsim-dbg/results/468440/13-peer-sh/stdout  
>>
>> I can't repro it locally in QEMU. Maybe it's due to the leaky ref bug?
>>
>> I'll send another revision and hopefully this doesn't happen again.
> 
> Grep for wait_local_port_listen, maybe we should make sure listener
> had fully started?

Ah, thanks. I'll add that into the selftest.

