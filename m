Return-Path: <netdev+bounces-137774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F019A9B91
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18335B24446
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 07:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F9415539D;
	Tue, 22 Oct 2024 07:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPlVqDxd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5028E1547E3
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 07:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583720; cv=none; b=HZkgI0PTyzNShcJesBkR9UyY6aNKEjhahFtpIDz8GLo1zIJFPDHHxU9rHBXwMRWXEOrHsEqGbJVK+QygaIt1F+A4P06gPGCW8vYmQF3H4IsI8Qioi9W6+nj4GmA68G1qD9kNNrOcYhuavGCpmnEsCVEx2w/kqyDChPR96llZGx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583720; c=relaxed/simple;
	bh=a5fyCyn5/+KeoJ5H7KZdKoLIh130Rz26wIz8f6adMwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eaXH1vRTxWAUo9EvyzU9GGbGWQlT4B9WCLiJzQLVVOj/nHFhwUXS+8dabiovX2YfBwcSMkMQ5dFtixnLj+OMrSVUn0RuvcOkKo8VcNPk5bX+P1GBc9fFHdcT0Hrh2teKNzBQrazs4cg7/S//mfIG+DWh5AERh0bpg/7fM06qwO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bPlVqDxd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729583718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4RsTcKNKaobs4jMFKvE9wpsPTBmi5JQtlHt77eXgo6k=;
	b=bPlVqDxdcg2paftxZ1XFpuwUqsYptEAyUYKdsz655IA7cVwL2esw+gQy+32iOUpTGy5N5K
	TLTM2kMHhKTnLUb0othFLs3S39tYEu0sGQctIVk0wCNownJT+cN/2lIOTC7Cvg9ENyL1um
	mgTWJpuf152Q82Usitgp+Df6Z1nJgtc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-G-3qcgYFPt-YSohvwWJjPw-1; Tue, 22 Oct 2024 03:55:14 -0400
X-MC-Unique: G-3qcgYFPt-YSohvwWJjPw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315af466d9so36838015e9.3
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 00:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729583713; x=1730188513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4RsTcKNKaobs4jMFKvE9wpsPTBmi5JQtlHt77eXgo6k=;
        b=dYrdjJ9TytUB6YZQ0IOpYjdrnYzC3YGS/lr0hF29AES9C1NxWzLe00P0btFfXl7pVa
         MOumVwzEz0+9+vcv4iqjzKgPsL5PVpy1YtDtHG0AKBeEOUGFK+wBWYSoqSFCvXYxNqCz
         eOOy+nuQZFHjYeX/GChK6Oa9n044FBD1iiUB7wM9wctW20F+TmZ8bkJb/bYSqghd2l7H
         VrImjV3qBTbPjov5HzRgoA1uvuIYtIAEex7QRWJB9V3uVgr4BASDB4tL+d3J0dcZJgu0
         RR3k4KVscLoyL/yvKC0atDCIJGTegDeDpIgeqCUOV3PBEYQl1O2TisVJ+wm3TzjvRU3u
         LfAw==
X-Forwarded-Encrypted: i=1; AJvYcCVAPKi0QjuDMuaoRcJVYeBkgF3Muil+q8JXLGAvSHDbknglBoE8V/o5Tjh9w+ti9raQ6rJKov4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuG+zaFyHfxrQJAO0qz6D/ViJtK0gf6bzGPsYE7j/0l1zHO4it
	vhYpMdfsjLUVcwAMOSXK92dndqxcLJvCjI/meeEj+zaF4fr30ctHiGyOJlMcPfqzxctemmyrIGN
	30pCQuIUh2lcBt9pfO+EVfgw8hJ236BYhr0/Qt3X/z+qpdk+yJ/BbJg==
X-Received: by 2002:a05:600c:4f09:b0:431:542d:2592 with SMTP id 5b1f17b1804b1-431616a3aaemr96891855e9.27.1729583713383;
        Tue, 22 Oct 2024 00:55:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg263MVUUAiOeI35WGJl18u4aEjjtVjip++92FND+04+jiBDN34kDO3wJgKXsS1EG4k1Zlhg==
X-Received: by 2002:a05:600c:4f09:b0:431:542d:2592 with SMTP id 5b1f17b1804b1-431616a3aaemr96891685e9.27.1729583713045;
        Tue, 22 Oct 2024 00:55:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910:d583:6ebb:eb80:7cd8? ([2a0d:3344:1b73:a910:d583:6ebb:eb80:7cd8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f58f224sm80567965e9.28.2024.10.22.00.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 00:55:12 -0700 (PDT)
Message-ID: <42743fe6-476a-4b88-b6f4-930d048472f9@redhat.com>
Date: Tue, 22 Oct 2024 09:55:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: yaml gen NL families support in iproute2?
To: Joe Damato <jdamato@fastly.com>, David Ahern <dsahern@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <ce719001-3b87-4556-938d-17b4271e1530@redhat.com>
 <61184cdf-6afc-4b9b-a3d2-b5f8478e3cbb@kernel.org>
 <ZxbAdVsf5UxbZ6Jp@LQ3V64L9R2>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ZxbAdVsf5UxbZ6Jp@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/24 22:58, Joe Damato wrote:
> On Thu, Oct 17, 2024 at 12:36:47PM -0600, David Ahern wrote:
>> On 10/17/24 11:41 AM, Paolo Abeni wrote:
>>> Hi all,
>>>
>>> please allow me to [re?]start this conversation.
>>>
>>> I think it would be very useful to bring yaml gennl families support in
>>> iproute2, so that end-users/admins could consolidated
>>> administration/setup in a single tool - as opposed to current status
>>> where something is only doable with iproute2 and something with the
>>> yml-cli tool bundled in the kernel sources.
>>>
>>> Code wise it could be implemented extending a bit the auto-generated
>>> code generation to provide even text/argument to NL parsing, so that the
>>> iproute-specific glue (and maintenance effort) could be minimal.
>>>
>>> WDYT?
>>
>> I would like to see the yaml files integrated into iproute2, but I have
>> not had time to look into doing it.
> 
> I agree with David, but likewise have not had time to look into it.
> 
> It would be nice to use one tool instead of a combination of
> multiple tools, if that were at all possible.

FTR I'm investigating the idea of using a tool similar to ynl-gen-rst.py
and ynl-gen-c.py to generate the man page and the command line parsing
code to build the NL request and glue libynl.a with an iproute2 like
interface.

Currently I'm stuck at my inferior python skills and -ENOTIME, but
perhaps someone else is interested/willing to step in...

/P


