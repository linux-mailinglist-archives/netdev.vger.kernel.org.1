Return-Path: <netdev+bounces-132769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 874E5993141
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D731F22BD7
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D421D9662;
	Mon,  7 Oct 2024 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Tr8Wb599"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1BD1D2B35
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315143; cv=none; b=guoxtVIJg4pFLwyEkYwiimleYFWmg5qyfS39kyP6GXPAB9v0i5cHQIf357NRNmgjAUZEbwf+tZu0RtCdYR86AdY+/M9bwup+w/DHsIykxNWgIECaO5q82g96eBeP1jGUCAQdSAftgfCqyIKKyaGO4Rxn8WQAv0xKHcRdyzKA4hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315143; c=relaxed/simple;
	bh=CBahcqfz2+DiRCFu5nNbvicXzTV8tQSW189znV4OB+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACv8VADlc0g8/2nUTVT3WHQpG0TMyme8fkZRJ1GSwJqrSmthi2L9wb9YiF07VmQvwt9QtSVZ4SDp7YcCNLtk2Z2k09pITRfVZxBOG4YVHIh1ahkUUfr1Uv+yNXZc2/qROc737T/01GxPD4lfjHhDOfrLs2UZnLFxtIjN6HpBQzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Tr8Wb599; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d43657255so739854066b.0
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 08:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1728315140; x=1728919940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XQNs1qjnfYwjN3Vib3tj+XAtlIbNXXkAQott8o9EnlE=;
        b=Tr8Wb599Rr0WZZZKdr1MiK1xk9qXuxNYxKhrpLNVcRAXRC21B3uI+biuh+Vyse1zby
         zGfaw0jGNKGrvOoC6OC9LGLos4yNCIgN+0qhZuJLWIZytlrx0qXo9yjSzxLNZJMs8Q96
         FYYYcNy+UOar2YLQcH5OLqZEabrd3Gub6bRCrevrzi/6mHY7XQdztef5hZySxFcUfeze
         KniDYOGYXqPXXVLOQuNPMLb9eHOQLGqeDmBFFYuY5kg+ApQv1gDpPKTp9qwzCUH897g1
         qC8/V0c2vOUf0M3doVIdqOta/Q7u8szTOu53ZTNGJAggDgibEDHcvlBXDvQZ9JeQkBIB
         VT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728315140; x=1728919940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQNs1qjnfYwjN3Vib3tj+XAtlIbNXXkAQott8o9EnlE=;
        b=U4690y1DeumBFlKvpFjxRqyqWF4Tz+RgJZn+SBDULpQlhAhSkPObXL0LEwJ2ywt0w6
         UwieW21339ngmiQEhR3pcDendkpznYi8/DUcY3ob1o4Bjsv7FwXD3gQuWaj6ZmpoJ8S9
         OUckhvdVXGEh5f4Fj1ShVwD/Lkzzeot+76KsahmQ3EC2OBwvXCuUDyxhhZ09fByLJpla
         usg6slCDDxCZNUMzOIi7pGlBZuUS6hZIuOLSQgNT5vZZhfTeIMUGlYAvGuw2kfAcVtH1
         36aE5NtCzi2+7m3sEYU5gTlKkSOIR077qcpwY2UFSHd47O6QSBiPC0AfDCAHdhwH1eIN
         ruow==
X-Forwarded-Encrypted: i=1; AJvYcCXnwK3iWtWIW4ZNDI9oKeOe3n51kBP0JEluh/WNPGU6GhGsBg1AzgjCZvgpIw6X2+KKEE4rG/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YycrFC+yBN8NlFrwdzMsfzdC/CpwA6ZKXkD53BOrSY3FR6XZQyR
	BmkGPGMISbgR7sUgyHR2kOUtwTa7cU3pOZbNZV7fkCzjrAk/t+29Y9RiO2eiLWSbi+MVh2Ms5se
	WH1o=
X-Google-Smtp-Source: AGHT+IHA9DQKhQbUtrzdO7UKpaRDaLReFhoaPx29Sqq8mjwLHD4M5lN+BrO3N0zU/5qAu3jyG9f0Ug==
X-Received: by 2002:a17:906:6a19:b0:a8d:2671:4999 with SMTP id a640c23a62f3a-a991bd9a67cmr1309579666b.39.1728315139471;
        Mon, 07 Oct 2024 08:32:19 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e8145b8sm388867966b.225.2024.10.07.08.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:32:19 -0700 (PDT)
Date: Mon, 7 Oct 2024 17:32:15 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	sd@queasysnail.net, ryazanov.s.a@gmail.com
Subject: Re: [PATCH net-next v8 03/24] ovpn: add basic netlink support
Message-ID: <ZwP-_-qawQJIBZnv@nanopsycho.orion>
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
 <20241002-b4-ovpn-v8-3-37ceffcffbde@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-b4-ovpn-v8-3-37ceffcffbde@openvpn.net>

Wed, Oct 02, 2024 at 11:02:17AM CEST, antonio@openvpn.net wrote:

[...]


>+operations:
>+  list:
>+    -
>+      name: dev-new
>+      attribute-set: ovpn
>+      flags: [ admin-perm ]
>+      doc: Create a new interface of type ovpn
>+      do:
>+        request:
>+          attributes:
>+            - ifname
>+            - mode
>+        reply:
>+          attributes:
>+            - ifname
>+            - ifindex
>+    -
>+      name: dev-del

Why you expose new and del here in ovn specific generic netlink iface?
Why can't you use the exising RTNL api which is used for creation and
destruction of other types of devices?


ip link add [link DEV | parentdev NAME] [ name ] NAME
		    [ txqueuelen PACKETS ]
		    [ address LLADDR ]
		    [ broadcast LLADDR ]
		    [ mtu MTU ] [index IDX ]
		    [ numtxqueues QUEUE_COUNT ]
		    [ numrxqueues QUEUE_COUNT ]
		    [ netns { PID | NETNSNAME | NETNSFILE } ]
		    type TYPE [ ARGS ]

ip link delete { DEVICE | dev DEVICE | group DEVGROUP } type TYPE [ ARGS ]

Lots of examples of existing types creation is for example here:
https://developers.redhat.com/blog/2018/10/22/introduction-to-linux-interfaces-for-virtual-networking



>+      attribute-set: ovpn
>+      flags: [ admin-perm ]
>+      doc: Delete existing interface of type ovpn
>+      do:
>+        pre: ovpn-nl-pre-doit
>+        post: ovpn-nl-post-doit
>+        request:
>+          attributes:
>+            - ifindex

[...]

