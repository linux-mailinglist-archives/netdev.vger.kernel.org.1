Return-Path: <netdev+bounces-246497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E01CED508
	for <lists+netdev@lfdr.de>; Thu, 01 Jan 2026 20:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5A6E3005E9B
	for <lists+netdev@lfdr.de>; Thu,  1 Jan 2026 19:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3052F21638D;
	Thu,  1 Jan 2026 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILVKKXCW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740921885A5
	for <netdev@vger.kernel.org>; Thu,  1 Jan 2026 19:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767296756; cv=none; b=DWXF8ogYc/AStpKEYIEK++ftSepJUIuHZs92Amp5h5gIwDF0g2KWwFi5kmsL2bTtY61ss1Qnmam0J7Fahe21yqmVjwC2W6WtyKJdGoTcACO7sAuokM5F1HPqvw6m+0AkgjTRubARCLWsf0Upn9nY85Ftl+vkkGDToj46yhMqLvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767296756; c=relaxed/simple;
	bh=bSAgjYB9EPA3Ys2YWM75ezah6V0QQ72fmsZoXfGr1+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M5c1dslWz7VGqtRbv+jhrR4ADf7ihnLmaw5+sfc3cjiPWIi8hurmf1q/64WCjk4mMIOscz/LdtNonRY7WXJm/1Ki0ANAk8bvZ2ogodNOdvByxyZtsYg4s1iMG2n97sgsHX79Q5ZZEBVy4e4wXjdN3nSi/TTnF/VB0757pk27GFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILVKKXCW; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78e6dc6d6d7so99428507b3.3
        for <netdev@vger.kernel.org>; Thu, 01 Jan 2026 11:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767296753; x=1767901553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OAhFdaLvRs7iUacPEf8Z2rB9Kc0SXtNutg6uKp0xro=;
        b=ILVKKXCWYkYpJif3ba60QrouEChLr1Z9ksYD3rYxSOlWGKlq2nA4tJjwz/Ai1vQwni
         pNnDJqgN7IJmW798ZEtApbofzu5/5oaq6qysaXjBqczbN4C8xZnSPHQAa9C6uRhKC1Wc
         j4rWytqjG5FjzOc3xJ8yadBozffV8H8kB87rFR5qxPXijZoEh0V2BCBLjCrOF73bW+NP
         D6RFDkjIj0krLA/sH6MX7vNf0xVaeUf+AuE6c76Mb+zeGyDdmmJqzWSbEZgf0g5NAeRe
         3XZpk0FeBwCdmtLfx6lZTk3Rrr6+suuMdcVm6PV1+nfpapqR2vZx0LTgyXeChuhskZH9
         jzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767296753; x=1767901553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7OAhFdaLvRs7iUacPEf8Z2rB9Kc0SXtNutg6uKp0xro=;
        b=G6n9C2+LActo86GYkNR5JDNJ4gSoKqVFOKAarbHSnFDOG6nuSDcgv9Bnkqzi0QEakB
         Hv0LIgtJ/rwjJ97HwAdM63vAqXEC9RiDWbTiYaM7WnFbxvjapbPb7KDmE69yoXu5FkWS
         ux52LgDkCYBauWYNJ0uqXMo+2H0kD0PK5n5cDJ9oQDrmbtqgoPgYLUyPx+2hO6tPD4S+
         d5of4vGjjEkQX5QnsWbiY+0ifHMp0xfxYjw3JbbQHjuTJq4iMupfe9CmVo7NUsWPDhsa
         esH4Zk+BhCDR1sK3qB3na9rbmfetPpY/2mj08tS9oFYAiN3hReYf8y995stMolpES03m
         2s/A==
X-Forwarded-Encrypted: i=1; AJvYcCXaotfOFBhtS7QIwlz8AL1rC265tXC/xkAAjbyh3SoOqWW6TdcoBrTwvMTsz6aW3f3A6MbMPOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIaOiQueT4ICFzEiA4sIh7J4/UBgrTgf8Lb2VwotI1MtuDGAXj
	l/nCf1aYbeaHu18hIO0da/pC1x/tywSDkdyyFSGwqf9ayQU2hsq0aKlB
X-Gm-Gg: AY/fxX6SgqD2sue7/wI3P7QdsIKLe76VQE3KeiyOo3RCLmQXjXoVh97HaCj8Swejen8
	OGbHoV8zrRFWb9XbCwAWL/X/eGUt+UwG0NWUNG3X/UatjuSoQosmisyvUK4nvMNLLhHWCvZTE6R
	9D7Ydh6/k7qom4Ibs3hpYSkFcDRZz9gqGVsccBnXeVRk7fSwRar+Cmq0q4UznV/Pwy3OT7nG1aH
	k2IExsUyfEP5hAwOVdarkUxJhpshTJiP0ZK4qpmcEIiKTWcil0+6PmAStaytx9HXVkfsPgulTaz
	HHv3TAf2CnVDFaMPyD3BPXPfcTeik3/rp1y3nc8sQPZtSKd3pV/EjbR7Zmw/naqIOHX7J8rNkfr
	8C0JIctGDheBtOtAg1CsPy6eURrBz2I2Hhs0NHSd+SvT0jLbRZZFw2w7Q/k5geJvw0MjMDVFiU6
	3QfUOYqUnQW8gAsLXyBOGfiVUOtjA3ToFrsqU6Rh9CYwiO7B/8Z44YqX96HA6S
X-Google-Smtp-Source: AGHT+IG1e2DHKPCMbaxwj/kHN9AdC9I6qKROsB4Uo1E2tjzY+gP5nAuCmg6HKpr62SwKuSL7R5/yTA==
X-Received: by 2002:a05:690c:46c6:b0:78c:5aa8:6dde with SMTP id 00721157ae682-78fb40b2632mr334461237b3.70.1767296753389;
        Thu, 01 Jan 2026 11:45:53 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb439b8acsm150472957b3.13.2026.01.01.11.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 11:45:52 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com
Cc: gnoack@google.com,
	horms@kernel.org,
	jmorris@namei.org,
	kuniyu@google.com,
	linux-security-module@vger.kernel.org,
	m@maowtm.org,
	mic@digikod.net,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	serge@hallyn.com,
	utilityemal77@gmail.com
Subject: Re: [RFC PATCH 0/1] lsm: Add hook unix_path_connect
Date: Thu,  1 Jan 2026 14:45:50 -0500
Message-ID: <20260101194551.4017198-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260101.f6d0f71ca9bb@gnoack.org>
References: <20260101.f6d0f71ca9bb@gnoack.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/1/26 07:13, Günther Noack wrote:
> On Wed, Dec 31, 2025 at 04:33:14PM -0500, Justin Suess wrote:
>> Adds an LSM hook unix_path_connect.
>>
>> This hook is called to check the path of a named unix socket before a
>> connection is initiated.
>>
>> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
>> Cc: Günther Noack <gnoack3000@gmail.com>
>> ---
>>  include/linux/lsm_hook_defs.h |  1 +
>>  include/linux/security.h      |  6 ++++++
>>  net/unix/af_unix.c            |  8 ++++++++
>>  security/security.c           | 16 ++++++++++++++++
>>  4 files changed, 31 insertions(+)
>>
>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>> index 8c42b4bde09c..a42d1aaf3b8a 100644
>> --- a/include/linux/lsm_hook_defs.h
>> +++ b/include/linux/lsm_hook_defs.h
>> @@ -318,6 +318,7 @@ LSM_HOOK(int, 0, watch_key, struct key *key)
>>  #endif /* CONFIG_SECURITY && CONFIG_KEY_NOTIFICATIONS */
>>  
>>  #ifdef CONFIG_SECURITY_NETWORK
>> +LSM_HOOK(int, 0, unix_path_connect, const struct path *path)
>
> You are placing this guarded by CONFIG_SECURITY_NETWORK, but there is
> also CONFIG_SECURITY_PATH.  Should it be guarded by both?

Agreed. I've moved it to a separate #if block with both
CONFIG_SECURITY_NETWORK and CONFIG_SECURITY_PATH for this and the other
places it was needed.

>
>
>
>>  LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
>>  	 struct sock *newsk)
>>  LSM_HOOK(int, 0, unix_may_send, struct socket *sock, struct socket *other)
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 83a646d72f6f..ab66f22f7e5a 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -1638,6 +1638,7 @@ static inline int security_watch_key(struct key *key)
>>  
>>  #ifdef CONFIG_SECURITY_NETWORK
>>  
>> +int security_unix_path_connect(const struct path *path);
>>  int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>>  int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk);
>>  int security_unix_may_send(struct socket *sock,  struct socket *other);
>> @@ -1699,6 +1700,11 @@ static inline int security_netlink_send(struct sock *sk, struct sk_buff *skb)
>>  	return 0;
>>  }
>>  
>> +static inline int security_unix_path_connect(const struct path *path)
>> +{
>> +	return 0;
>> +}
>> +
>>  static inline int security_unix_stream_connect(struct sock *sock,
>>  					       struct sock *other,
>>  					       struct sock *newsk)
>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>> index 55cdebfa0da0..af1a6083a69b 100644
>> --- a/net/unix/af_unix.c
>> +++ b/net/unix/af_unix.c
>> @@ -1226,6 +1226,14 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
>>  	if (!S_ISSOCK(inode->i_mode))
>>  		goto path_put;
>>  
>> +	/*
>> +	 * We call the hook because we know that the inode is a socket
>> +	 * and we hold a valid reference to it via the path.
>> +	 */
>> +	err = security_unix_path_connect(&path);
>> +	if (err)
>> +		goto path_put;
>
> In this place, the hook call is done also for the coredump socket.
>
> The coredump socket is a system-wide setting, and it feels weird to me
> that unprivileged processes should be able to inhibit that connection?

No I don't think they should be able to. Does this look better?

It also fixes overwriting the the error code when the hook returns.

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 55cdebfa0da0..397687e2d87f 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1226,6 +1226,18 @@ static struct sock *unix_find_bsd(struct
sockaddr_un *sunaddr, int addr_len,
        if (!S_ISSOCK(inode->i_mode))
                goto path_put;
 
+       /*
+        * We call the hook because we know that the inode is a socket
+        * and we hold a valid reference to it via the path.
+        * We intentionally forgo the ability to restrict SOCK_COREDUMP.
+        */
+       if (!(flags & SOCK_COREDUMP)) {
+               err = security_unix_path_connect(&path);
+               if (err)
+                       goto path_put;
+               err = -ECONNREFUSED;
+       }
+
        sk = unix_find_socket_byinode(inode);
        if (!sk)
                goto path_put;

>
>
>> +
>>  	sk = unix_find_socket_byinode(inode);
>>  	if (!sk)
>>  		goto path_put;
>> diff --git a/security/security.c b/security/security.c
>> index 31a688650601..17af5d0ddf28 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -4047,6 +4047,22 @@ int security_unix_stream_connect(struct sock *sock, struct sock *other,
>>  }
>>  EXPORT_SYMBOL(security_unix_stream_connect);
>>  
>> +/*
>> + * security_unix_path_connect() - Check if a named AF_UNIX socket can connect
>> + * @path: Path of the socket being connected to
>              ^
> mega-nit: lowercase for consistency
Gotcha.
>
>
>> + *
>> + * This hook is called to check permissions before connecting to a named
>> + * AF_UNIX socket. This is necessary because it was not possible to check the
>> + * VFS inode of the target socket before the connection is made.
>
> I'd drop the last sentence; the defense why this is necessary can go
> in the commit message, and once we have a call-site for the hook,
> someone browsing the kernel code can look up what it is used for.
Sounds good to me.
>
>
>> + *
>> + * Return: Returns 0 if permission is granted.
>> + */
>> +int security_unix_path_connect(const struct path *path)
>> +{
>> +	return call_int_hook(unix_path_connect, path);
>> +}
>> +EXPORT_SYMBOL(security_unix_path_connect);
>> +
>>  /**
>>   * security_unix_may_send() - Check if AF_UNIX socket can send datagrams
>>   * @sock: originating sock
>> -- 
>> 2.51.0
>>


