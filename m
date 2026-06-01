Return-Path: <netdev+bounces-293701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mO+hMAhuHWrlagkAu9opvQ
	(envelope-from <netdev+bounces-293701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:33:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2B261E5DF
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1486D3009F49
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 11:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D0A35E93E;
	Mon,  1 Jun 2026 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="NxZq/K5P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E264234CFDE
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780313602; cv=pass; b=okYawhQ1i5QbrzjaHmuoyDKbcIgc+az0NCczyAHOtPYljcKGfRFIn8S28kzi7EExIWesvt3yVK3Sn9NmaY0ftQzbuBe4scyk2YEfBDJ8BYokEQve5QG1nj2kAhUii1BBku6dP2xSwugu5jk0gJ1CdsVExA4WkNMVMlZ7F58ZksY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780313602; c=relaxed/simple;
	bh=uVMhWSI3M7PqFpwkfEATZt8vBsIE3hJ1C0QZF5LG9t0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dCmogWgQ3LvQ/pmR82lWTWHwWdc2FbikibjFVedUVYOMya6Uu28ZW4wxKjbgBAeXlucEjCHsqNbdFz5/wY3zaWxr3rrAkYxYCrSt0Nxx82hMvZEdo6n7aCmak2DnyDsHhx6U8a+x1/UuElNIMyzjKqmMGUcE+XGAyLCT87qPR0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=NxZq/K5P; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c859a374903so391263a12.3
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 04:33:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780313600; cv=none;
        d=google.com; s=arc-20240605;
        b=IH9b3i3Gt6NyyWaLsP3TaVXLx+T/GImzlhCFrvypX4iLRah52kX9te2u5j3J/zSFM9
         pGf8bqBGl6G9mko4xrzm4F9t6w5K5LVuyYSk8S4h/rD/5n34egOSubFqPto3FJKlu5Vc
         MTyhie+W2EQzmyn/bj4PP4+X947fy1yvtA9sRhbW6eHL42lTi3qu5BpEHZWwjK/Wb0FW
         2bBSM81dYSdFKQR400edDvVTNOGbA60jyi0E+kVnXQpoSKubfFyUhHvotvQw8jWA8M97
         XNnaD4klsaM+S6u/yzGxILp/SVfz5sdekYcx6Ba2FhWzuKcijVc/tBk7sBDH9nZsfRYV
         93IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=uVMhWSI3M7PqFpwkfEATZt8vBsIE3hJ1C0QZF5LG9t0=;
        fh=uRj863t9x/xaEvA46vPf9XZ+d1kJdY0oDilRPeh6bE0=;
        b=VtKjtLVCUBQ193l0O9jw4mjk8GLxiG7Um+s09ban+kHMLsMxTPdjJYabfTwgImvQ3o
         pgCXyG1tZFWgFDvaPMcxUygeJXT7FzuFVgE4lS15JNEvN53bX07qhfiEdFiE6OZDkHlE
         v/kZkGmMSCM9KZlsoxi1ybpHzGL/PCAkxwSGKA5mCiR9E/dK4NqGr3gCcSUOd4I+vFA5
         2Us10essk4g/YJgrVJDwaGY/+ZBYR2KzpYM3sAnBt9eRG2OgcW7a+q5JzGnyEAKPHwdS
         9vWDDAVbEr5MwnULU6e0YkG0PALTCUQ6BQEqmuyX2rAFhQOGFfovS2XrQ5HQryRGPxvg
         idQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780313600; x=1780918400; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uVMhWSI3M7PqFpwkfEATZt8vBsIE3hJ1C0QZF5LG9t0=;
        b=NxZq/K5PUE0h0E5mGzSrCcr06uEotsZJnn5qP20NrM5IJBFexugyZDJon0nmo7VDjK
         LAsOk5Kav4Jj2LBD7XkQV9KBDwQ0DJjBWBd2u5tdFg443tQC8c/v4YGU0fSgAeinMXtP
         UILenMZXPIcO414OeOhdT3GDiKYB3rE/cdROQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780313600; x=1780918400;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVMhWSI3M7PqFpwkfEATZt8vBsIE3hJ1C0QZF5LG9t0=;
        b=fH2UNrVw6bP8FJL55ZumN9gf7VjDyzd/QT0iEhQSUevrWyyiIdBky41O53R3gm8mk7
         dsjPhcyG04RmwLyerZUnGDHcBbqRoCEnaOPrxZT9VQA4mWXHV9QLCIkNFBcbep7rWLmy
         UxYCYvRxaVUttCwjSOAwoqjk9uuohvRqte51QhZMrhUjnUE1uGOIYA2ZCuEje69ImnmG
         43rEAg+RMlreUH90rPKnBwHa3G5H8O+r9Sw4GqE8KLV5tf/mZyn8QqE9JWchuxDjmof4
         JsVMUJ6d+DDxiby9R1IUdteO2h8XEfoolgtFzAYQKbTpebKv3d3zWs445ivG4rBt9aMx
         /HwA==
X-Gm-Message-State: AOJu0Yw8qtpjD3StYmeHiJUhZ37/30h6jyZg6e6s7U0BxIqGcV8kYxLg
	OE3p0WL+exsWiKQ/3D8pvz1SppmAelTFPqVYMl8k6c9OZjxCGixPghLzcIIDnd6lD13utJY81xt
	vyN3calgtRbIxi1/fuLcO+zZnSTW6dsfMdIMcdAQGxdo+Y7AHcwEr34Yg
X-Gm-Gg: Acq92OHH07l1oFfEM93FmW2Z7ApK1pq7WTYHMyrGERK0w8A+hMMAFs/X6lY5+/hNqfy
	u+JRsKxSKbXQEMqCFYj1BQIqG9Ubng9RgG9R+Vj5gsEjwZYb6FaXQQDNlPKJrUddx6AWFBeoj7i
	g/MNfw97KXw0RMslRZAEHDwYQGNQUYK9ExSquQa9wAr+x/uVlbQdxHVgnKbT9hoLC68o4US/cLs
	JDXzsKKFFDMsdgDQuzVeNuvdEZ1jAMyLKRdgP6Uu4NlRPe4e7Tm8sF5mrJBPBywF2AkV57Qg2+q
	LIB5ALwSgZJ6n3Lvv73ecyuaHg==
X-Received: by 2002:a05:6a21:7a96:b0:398:b433:87ed with SMTP id
 adf61e73a8af0-3b427f5dee5mr11677802637.44.1780313600132; Mon, 01 Jun 2026
 04:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 1 Jun 2026 07:33:09 -0400
X-Gm-Features: AVHnY4I4Oq7kfzkvATZfqv_I4dIxsQYBxFxWE5rf6WImcq-_O15EbAx7JO-P5HE
Message-ID: <CAM0EoMkbu0Y-qhtdQ03Zn93JKOUHd6yZy-DJ2mtYDC6aehsR6g@mail.gmail.com>
Subject: Call for participation: New Age Tooling BoF
To: Linux Kernel Network Developers <netdev@vger.kernel.org>
Cc: netfilter-devel@vger.kernel.org, 
	linux-wireless <linux-wireless@vger.kernel.org>, netfilter@vger.kernel.org, 
	lartc@vger.kernel.org, ovs-dev@openvswitch.org, bpf <bpf@vger.kernel.org>, 
	people <people@netdevconf.info>, PJ Waskiewicz <pjwaskiewicz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293701-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,openvswitch.org,netdevconf.info,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,rome.it:url,mojatatu.com:dkim]
X-Rspamd-Queue-Id: 5C2B261E5DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Apologies for the shotgun - I wasnt sure how to best reach out given
the short notice.

The recent AI tool bug onslaught (on the victim side for me) has
highlighted the changing landscape on development tooling.
As an initial skeptic I have to say the quality and accuracy of the AI
analysis makes me feel like i have been in some deep slumber. I am
still very clueless.
And for these selfish reasons, I am helping organize a BoF at
netdevconf 0x1A (week of July 13 in Rome.it) to discuss this new age
of tooling.
This BoF is a catch all for folks engaging AI in security (you will be
in a friendly environment!), building tools, doing code reviews,
generating patches and general automation. The intended focus is
networking, but adjacent areas are also welcome.

Come and discuss your tricks of the trade. The contribution can be in
the form of a talk, tutorial or demo.

cheers,
jamal

