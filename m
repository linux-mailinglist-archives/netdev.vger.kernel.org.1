Return-Path: <netdev+bounces-270614-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOAmCvBzwWkQTQQAu9opvQ
	(envelope-from <netdev+bounces-270614-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:10:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C582F987D
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FA223121ACA
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A4A3C3422;
	Mon, 23 Mar 2026 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NyoLjvtt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6F93C1978
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774284263; cv=none; b=gstSlJOoKebfQQdvdfLGfx1sifHz+RYGQYqX/f95bJV+VmNZnjZvF/XyYe2b90pZA5/bN7vs+k2mbhsbV1l1m1IXvWtkRM2OOBpWeWhVaoPqwMScvnOpTmjdId6HwnGHmn9OaXERDivWaluqS4EMxZrgwLPDhCPl0xGoYssQWE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774284263; c=relaxed/simple;
	bh=LBK1GfTkPqN/J3ekXfWul5rM7Y0N9TEPGG3iPFdaMvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BGtdtO5xK/Es9vMkclwk8RSvdClTeTTKF/qfXLy8J0ZyFJu+6nDPOOk+UCfkZtn3ByfEnDSSoED4Xq3LBDG8naURG5aXUIngV2Fim4RM0SAka0txaeESIuHK9wI6+ziDGMRm8r1V5aIOCbldD9jinA7TzFsv/78Ehd18Wt8NyFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NyoLjvtt; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d74dbfe84cso249264a34.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 09:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774284259; x=1774889059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F+mUNq7tmfNnDvMUw7l2UsagRnrJrQ3LN33pu/ZkAt8=;
        b=NyoLjvttGaqUi2qQdd/BWFA5gUXTdp5SiHrUL95B6IdPIzMlHXKSFtQJACLpfCbjjT
         ezrNB7amSMh1fxXOWG1zOMGz6QC3UdI6Y2H8nMJ0vxmrdaicm3AEyDP3E5BuGHdviHg0
         +wZ2cuN5h4ev6s6kJu75whMjQxzzzV94U/f07UAzm3ZKUJcop82jb6NImgwQaEH6OCEh
         4wAxiOK4x4Pe5QRvQNrF2kjFqCFvQNzVPrEOD6wE/kRRv24iCOcv0Jg4KWZS2z5Ajspz
         s/SO8nut7rCN0RF3VqvZkqF/09uUJLyLoBkhYcaGOm9zppIKwLPGYJQbMbODnC92OLhL
         59jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774284259; x=1774889059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+mUNq7tmfNnDvMUw7l2UsagRnrJrQ3LN33pu/ZkAt8=;
        b=BNct161GKnizWyl9UgWt0zPyN4yz3wFqhst/hzEbQaYB61uyehPpp/aUkEgq3ezDjs
         kkzvBEhO86rFGryywa+IaWxeO01NuUHrNWj9OuyLtXI77xJ5J7oxjy5vCCs2eVDY0138
         CU5nZK7ZfLwjlgyirls6X3HVKovpSkBbWctvwplULixGJm++Q6xRNxeqUvAYQeWAna9v
         zl/x8ikyskKyImOLi8ECoMDRI97OW03Jchr2i9bcQ0aoXkoMjh+CEF9RWUq2uV1wR8KH
         hfmN5kEZ1PqwcTZ4/gQ8Zi4T6NbY9pjsKTygFkoGJWt0VpO4h7/E+vgI5HGfnZbvdIgM
         5P8Q==
X-Gm-Message-State: AOJu0Yw6Ua732I7xgTyTCGS+4wJiFB2KDc+QADCj0HCVS9u4+Ox1elbe
	wBu/fAoKa6myx2e5MsyUpOkSlITu++dMF0fkqACk0j4S2HhchlSUDe0JcDCttZXPtOY=
X-Gm-Gg: ATEYQzyi+r67iTfUmLj0dEZ3kwn8k80xaw8J9mUVn2rcJd+MexwDr/xw3X0E58Eu/AV
	h1wWjKAO96ZfbL7pR8noUiYCC/1TdvsFGDp4c8ZHxMfyMQMcu/rGuZVXuYH51++EebvCLhJJtwe
	prnSgsdV5AxvkeKbnUmYLlPioRio9ZREPiJfwNXggZEYZQCw/7KyL1747G9a3EeC5Q3Y+tRmG/P
	RWt88gqyi+5e2aqQLnP67PObx+AZ9vovSCK6Kvrf/G5Jw9Rf87v3PXl7UOaOv/IeNfNny6yiDvQ
	vgJHGtJL1qnT8NphSp88t6BvXZnhc+RquztyU+YPjh9qtWMOzOzLH19KUMZcDCKZ6CbHGqIPGXy
	7tH/Lia7LxnyZb8hcRIaoYKYnxQrNJGETjhiqYIPyUpq8krEZXk30Otcx+lMM2ojsVbKt7q+Zkh
	ssQ572DQNIHaO+KkzZ9n1oiQ+ynLyEBh2Yhku4p7sJPB1Uvu/1N6PkMkdhv2eHGBQXuN2BS8T/Y
	wyoNDH0
X-Received: by 2002:a05:6830:81cd:b0:7d7:f15b:bdcf with SMTP id 46e09a7af769-7d7f15bbee3mr8134708a34.28.1774284259411;
        Mon, 23 Mar 2026 09:44:19 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eabe8dfdsm10044182a34.5.2026.03.23.09.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 09:44:18 -0700 (PDT)
Message-ID: <71c67415-497a-489a-9b98-9c85ae89a8f2@kernel.dk>
Date: Mon, 23 Mar 2026 10:44:17 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH io_uring-7.1 01/16] io_uring/zcrx: return back two step
 unregistration
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: netdev@vger.kernel.org, Youngmin Choi <youngminchoi94@gmail.com>
References: <cover.1774261953.git.asml.silence@gmail.com>
 <0ce21f0565ab4358668922a28a8a36922dfebf76.1774261953.git.asml.silence@gmail.com>
 <1b3ad321-866a-4cb8-9810-5eae7805647d@kernel.dk>
 <d1981803-0b3a-468a-9fe6-a751470cec26@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d1981803-0b3a-468a-9fe6-a751470cec26@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270614-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A0C582F987D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 10:14 AM, Pavel Begunkov wrote:
> On 3/23/26 15:01, Jens Axboe wrote:
>> On 3/23/26 6:43 AM, Pavel Begunkov wrote:
>>> @@ -898,12 +933,15 @@ void io_unregister_zcrx_ifqs(struct io_ring_ctx *ctx)
>>>               unsigned long id = 0;
>>>                 ifq = xa_find(&ctx->zcrx_ctxs, &id, ULONG_MAX, XA_PRESENT);
>>> -            if (ifq)
>>> +            if (ifq) {
>>> +                if (WARN_ON_ONCE(!is_zcrx_entry_marked(ctx, id)))
>>> +                    break;
>>
>> This break is inside the scoped_guard(), does this need an ifq = NULL
>> here? I do like scoped locking, but this seems a bit tricky...
> 
> That should work, want me to resend or would you amend it? It's a good
> thing I was pointed at it, but I'm not too concerned about this case as
> it's a warn once.

I can add it and add a note. Outside of that, I think the series looks
fine, no further comments.

-- 
Jens Axboe


