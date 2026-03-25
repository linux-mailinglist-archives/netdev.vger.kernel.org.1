Return-Path: <netdev+bounces-271526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Lk7Mg/bw2lwuQQAu9opvQ
	(envelope-from <netdev+bounces-271526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:54:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BECE325411
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FF28339C7AC
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB5F3D9DBF;
	Wed, 25 Mar 2026 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1S7SGGm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10533D9022
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440844; cv=none; b=ZY1cpuEfcPNPK4VCa0DQzaHApzMC1LVNkIsiuauoNPQnoVkbFHF+O+rvq9BxR15u6BSFVDc8MzKGZw39MpO5evtlDWhUFwc+0Dp2YZqOE9sdR3hiqg7kblXle1V8wdjOBARdxSkYxWWokIUfiHnX9ZbFj+X/f3gPkYceLUIrUlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440844; c=relaxed/simple;
	bh=IBlgjftKWIzJoKPeHDWZXyguS3yOOLm3fUl93OEa0Zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mftu74UoFL9B8FAdZFAeZOaXjYm23iFWO4hxi33YPNYekaC4MZcB9gUtOCbU13oYi+ZVeMbdGS5BeCJF45MUuMu4X6CHhcgUaheAr3oP7N+4izDdngD0hm8XuNqtOLAvLmkiVS4coFx2h7kjBArNTyZpGrvwt0ZZCRqstnQeAYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r1S7SGGm; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43b5bded412so1838728f8f.0
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 05:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774440842; x=1775045642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hfPA5C1hRF77uQdfUHH+kcK62hjQci3PCygqqe1s0nc=;
        b=r1S7SGGmpiL4Ebn5JDqRyh+0v9JhmzsZ2/tsNdRX4iL4UuQBQg21/nAB9S1NhhdGpE
         mGkTxsg/byy5eQGv1gGRgajk7CgnA+PFwn3B4tLiSUU2wSf10C3RW6DMdcEXz22l7Bpz
         w6OwjrOFUn/l6cl3Umr9yduxZJlxxd9yvmdonbb7vmkG5Ly1XuoDeMSjsYpLgkfnet6b
         OS6Jd++o2mptWy0DjHm07hhAReCfaD5MKudoJa6zkI5/eTzMZsCTUvAALIgme/C1ELC7
         O79HKGn29TXLUrqcpdeTkR9AOgpGK0+VVfikhMSPDVHs5RpmbwU5QVlZwzXHiGMFytDx
         79tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774440842; x=1775045642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hfPA5C1hRF77uQdfUHH+kcK62hjQci3PCygqqe1s0nc=;
        b=DcGcpBJ5H3MbTOyAAhjVsI23ov1laybJqfqKz1g/6nGVuuwKpzTfGI7kkUw48TQSOO
         jIvcK64ljVf+gXuYxGloVH+zx4ciqfWFNkOv/alpF189CIgoz+jUmAzGuce0zzqt/Pl5
         KrB8ytbsUzWgwaSGJASEh7QnkxET5Mg2LNPEwhXBpn3cLSA6awrkFz2Q9bZd7SD+liI0
         G7KNHwmzIZSOmeqM3tJFa2aDZyCXUOz7D4W7GahEV3pQrjo5q6hhDM/sBIp6ut66oGtK
         u+yXKzNylDuTG7g/ZUOpCwHSTQgs7L4UCWfWYl7nuW6QnQwS3fms2UyL4zWdtkfmLLJY
         OLMw==
X-Forwarded-Encrypted: i=1; AJvYcCUXtVACCqJhmVp/dRQd2/mlm730HuKTk2sXiyeNwq7mh/vv9DhRUbvS6tdB0DTwx3RNKlc7Mbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLWfovIs8rQIN7xEi8glrDQ0hQ8peiVFXtQ78h4t2vg/uBdMVE
	wmeAmvoVJ6WvNORVTGlIFG7CsLdvxfcaWABy1a6qYdq5ztrIU4PwmIBkzkvciw==
X-Gm-Gg: ATEYQzznvH6qOPRXTTXIjt0GAqRZXDZCIp9AFUP9CWTKxaSSuP/URg77f4o+TZn6UUa
	2y0shjmzOK4bwMv83FoJD96av24gFq9eQeYnFG38f7pDhq+0zLE5qqdcNiMXI/5iVmEEik4Wp7I
	oxnyVM0cxsd76ksXLQMJuTJOEavDE9U91NNZstK12RbjH3Uu87RRcGJrB2MgmjtKIaOAitSyQQY
	UPVQUGEC8wguXD38cCiSkBfdDl7k4ILfpZFaSsa9kfZTVgc8fnob8u4o68ozN2oxopW7agIt6oO
	5zsosGtumRcOKaO5v8FONUvOlFvgTI/GKqFpqtR8rFtHFp3TLNym4VASnpAtWx5N588MVORxJHO
	nDagADNOVYKcGcDZF57562lP0KbagVjQ+w/AzjAdh79e6ln1924Pagw5iLsOwVObI6W2l2v9PeU
	d54zA3wUjniW3XWuxmO2vRFWL+9kaivGwuBhj5X1cxB4TtiUUEuX/zqSDs15TcVu7VMZgPmze3t
	beYOBWnia6v+n+4u1aFExbVgag02fODPKVUF9M=
X-Received: by 2002:a05:6000:2401:b0:439:b6ae:5d5f with SMTP id ffacd0b85a97d-43b88a1a8f4mr4884625f8f.36.1774440841891;
        Wed, 25 Mar 2026 05:14:01 -0700 (PDT)
Received: from [100.112.116.159] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64714decsm41468669f8f.31.2026.03.25.05.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 05:14:01 -0700 (PDT)
Message-ID: <3aa1fb50-3a19-403e-99da-b8a12fa54104@gmail.com>
Date: Wed, 25 Mar 2026 12:14:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH io_uring-7.1 0/4] follow up zcrx fixes
To: io-uring@vger.kernel.org
Cc: axboe@kernel.dk, netdev@vger.kernel.org
References: <cover.1774439286.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <cover.1774439286.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271526-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2BECE325411
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/26 12:08, Pavel Begunkov wrote:
> Follow up fixes for the recent update flagged by review.

Actually, I'm not happy how it interacts with the nodev mode,
I'll send a v2

-- 
Pavel Begunkov


