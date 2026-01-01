Return-Path: <netdev+bounces-246536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6F4CED8EB
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 00:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F35D300A355
	for <lists+netdev@lfdr.de>; Thu,  1 Jan 2026 23:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E8826C39F;
	Thu,  1 Jan 2026 23:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0/iEmZZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071C124A049
	for <netdev@vger.kernel.org>; Thu,  1 Jan 2026 23:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767310855; cv=none; b=OZQYl+4ED5g3cJUPMKMqCf1F+wNmFh7ZGF9GccfXxUcEdcS9YFEi/3lfmwHEW5LrWJ9qhPMZbb2DSxxtVrV8LAJ/4jH/L1y5as685H8q0sk+lq76jehBJsbQlmIVvYWL3bTAvdnPGec4MfZgIki8Ilu2MJLwHZ81ePZ1ECwN3Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767310855; c=relaxed/simple;
	bh=cHaOplRIv2s5yEHDc1ml8DnxLbzB5UiibX4F6W3wE34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmM4zWI4Ig1OCgDnY+1gStjC6gVlk6hezTlGaTGSXzylR9vw+irMFJJoR8BcMg8qXGfAyceyJLr8+kEERVmttANywSxFkaBzA6QiJWDuy1C0S9MTb1+BHIREft2uFVELypOLZhyf7cbTROTfbrJ8E97XX6WANFaDQb03nWneYDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0/iEmZZ; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6442e2dd8bbso7953576d50.0
        for <netdev@vger.kernel.org>; Thu, 01 Jan 2026 15:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767310852; x=1767915652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BaZgB/0vC9aWPnmDin2g8hReSOJZPuV1mCiVW+Kasj4=;
        b=O0/iEmZZqSD9Rc8fkyV8S2qn6GX8EyJj7/+lo3yO/e5ySoJNGm2HmM2iQDCBPyiffG
         ecHGK/XR3PLenx44KuDjMoQOrsSOI/6xawQg1C5aMaxpoqb8fckDFkW9dkfZ5dISdXvD
         51i7d3sk70ZclP4ez+SbzIyYerftuq1ufPujG2RZ2LbLcArmLRXHnN11ckhfCOFqIXO4
         6QlbLAwzwSNLrnO4cEJt80we8L5LBfalVPi/GxCi+zpYml3NsHEeBwuV7DkVIlQFIZdd
         eVClHn9MuL05h9RVNWfQMJ5a/LEE5dGfJYQY6pz6yfba7qQne1FF81EbPBRM4XdD7M1u
         6LsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767310852; x=1767915652;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BaZgB/0vC9aWPnmDin2g8hReSOJZPuV1mCiVW+Kasj4=;
        b=FTDP7MKEu+u069FbRcbV21VmbAk7R7/OHj62NKi4JiUDB9EWjok9mkQoSqv/kSzyhc
         GhWiyQzzlxlQJOBv9dSkf1I5NsWnob7OyCkh7ah5McfmRsyPYa/SnqSCPF/xYhfGXPAi
         fN8UqrW6/YiHxR+yLGROQW6FQo1v9MYA3ZfE6juKDTa02Y0pv/o6gRiSD+0tH8d6SZ38
         +PzR08wSm//OhB63bn+8hL/bu7mUs6ZLSIDeNWZnc1jeROXZpmFypcJgMtLvSuSVhekz
         mA9MahIQMyHGDDUnQYShtuciQui0OWQxoOwMiw0bulkhdtic39oMrm6nA6qTrkzTNTab
         yW9w==
X-Forwarded-Encrypted: i=1; AJvYcCXuqayvFBiCsmcxr11jBFkdRicJPYBmtv25UZCc+5Y8lZvTIfLGpJrxFkGFSTO5hZdgT23AtyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaZTEznM6A/h4ZyN7vLUdhYUwOLkJFJUFXf6fNXuC3XpVXs5Zi
	zcU5y4DxjgnOmhKDjBZNGqVecCmEyu9cb+JtW4LioW5+zufEisaK67Oo
X-Gm-Gg: AY/fxX7c5mnBMJDTYtsoyazBSeR10LvHxj+C1I6BbiPx7n9OZQvfajp+4EipSdez8d3
	C6uo+T9wKR6T1GHoVCDwnYgkNfk19gbxR/4+OyBAdfKw66gHi7F4zxCqPhseVaFxQtGQc1+8Oj1
	K/Q9XaMnjXR+OsefQPWuXmIRjZFN8g+o6li9G2HSGAVwnbOcpJzXyRGZphac0i6FKMoEFP2+UBn
	lqujL7wOKyry5Uwnl/PQqD4OGW9fvh/TiQBFKm1iohC/U5VkAprD/XQ5OrKyrXq8cq3zr9CG6cX
	0iL7SxSyFJ7mA2+Ea7/zM6XwNoRAhI7bMyUpT+Gnh8TJemt0aHzMknaoBPY9+jEHcYyjjqb98Xd
	m6w3B8R9k7Eb22/8zMvOI3JIsFzXui1YRLQQJJ5n6NJ6U3UWm8V+txCE+aDEWYV0hVn++Fma2WL
	c7ncp8lWOirUz+rC5KiSbCzJWQnXqyvd6B2DUQD9V1SBV7l6mB17HAKX01+VPDrAafy6e93g==
X-Google-Smtp-Source: AGHT+IHO4l5iOHN18kmUpzMMZ1XijQJRBwTQEPahlD7N2hLnBbuPsKliSlV73wybrZLK6ihf+dc6og==
X-Received: by 2002:a53:d846:0:b0:63c:f5a6:f2ef with SMTP id 956f58d0204a3-6466a901165mr25743473d50.65.1767310851998;
        Thu, 01 Jan 2026 15:40:51 -0800 (PST)
Received: from [10.10.10.50] (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6466a94072bsm19229805d50.23.2026.01.01.15.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jan 2026 15:40:51 -0800 (PST)
Message-ID: <714c39e3-61fa-449c-b4ab-bdb41a35fc40@gmail.com>
Date: Thu, 1 Jan 2026 18:40:49 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] lsm: Add hook unix_path_connect
To: Tingmao Wang <m@maowtm.org>
Cc: gnoack3000@gmail.com, gnoack@google.com, horms@kernel.org,
 jmorris@namei.org, kuniyu@google.com, linux-security-module@vger.kernel.org,
 mic@digikod.net, netdev@vger.kernel.org, paul@paul-moore.com,
 serge@hallyn.com
References: <20260101.f6d0f71ca9bb@gnoack.org>
 <20260101194551.4017198-1-utilityemal77@gmail.com>
 <b992df90-92da-48bd-91d1-051af9670d07@maowtm.org>
Content-Language: en-US
From: Justin Suess <utilityemal77@gmail.com>
In-Reply-To: <b992df90-92da-48bd-91d1-051af9670d07@maowtm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/1/26 18:11, Tingmao Wang wrote:
> On 1/1/26 19:45, Justin Suess wrote:
>> [...]
>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>> index 55cdebfa0da0..397687e2d87f 100644
>> --- a/net/unix/af_unix.c
>> +++ b/net/unix/af_unix.c
>> @@ -1226,6 +1226,18 @@ static struct sock *unix_find_bsd(struct
>> sockaddr_un *sunaddr, int addr_len,
>>         if (!S_ISSOCK(inode->i_mode))
>>                 goto path_put;
>>  
>> +       /*
>> +        * We call the hook because we know that the inode is a socket
>> +        * and we hold a valid reference to it via the path.
>> +        * We intentionally forgo the ability to restrict SOCK_COREDUMP.
>> +        */
>> +       if (!(flags & SOCK_COREDUMP)) {
>> +               err = security_unix_path_connect(&path);
>> +               if (err)
>> +                       goto path_put;
>> +               err = -ECONNREFUSED;
> I'm not sure if this is a good suggestion, but I think it might be cleaner
> to move this `err = -ECONNREFUSED;` out of the if, and do it
> unconditionally above the `sk = unix_find_socket_byinode(inode);` below?
> To me that makes the intention for resetting err clear (it is to ensure
> that a NULL return from unix_find_socket_byinode causes us to return
> -ECONNREFUSED).
>
I'll do that. That does make it more clear.

I suspect resetting the error accidentally was what caused the syzbot to rightfully complain.

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 55cdebfa0da0..2e0300121ab5 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1226,6 +1226,18 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
     if (!S_ISSOCK(inode->i_mode))
         goto path_put;
 
+    /*
+     * We call the hook because we know that the inode is a socket
+     * and we hold a valid reference to it via the path.
+     * We intentionally forgo the ability to restrict SOCK_COREDUMP.
+     */
+    if (!(flags & SOCK_COREDUMP)) {
+        err = security_unix_path_connect(&path);
+        if (err)
+            goto path_put;
+    }
+    err = -ECONNREFUSED;
+
     sk = unix_find_socket_byinode(inode);
     if (!sk)
         goto path_put;



