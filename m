Return-Path: <netdev+bounces-260080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mG2mF6xvnGmcGAQAu9opvQ
	(envelope-from <netdev+bounces-260080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:18:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 002E9178A06
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EC12309B43A
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5CF366546;
	Mon, 23 Feb 2026 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCAuJECM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFF7364E89
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771859643; cv=none; b=T+mcL3ZqYTtsigzT0PST2dLqx04IZrS0icsSJbEe4h5dAKMcsijWBeFHnMc1WeRUDbLPHWomA47ePonguHyfahp7hrRF1vLALl2D95L9FRk70e1uySkTimEGukJ2gqgUwtjjV2LZajiXVWnUTR1TmP5BNIIbcqdmIPJUkiGMdDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771859643; c=relaxed/simple;
	bh=VVXHRQLJVIkhPd2IDyY6/3ocuYzZkGuoft6mcPOs7Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=khX/cepFtHkxHUHT85n3GILscEveheHimg8BtYYmyC6xacltXRM0M3W8BA36azZwv7u7QQ456OGQgVYUxBZ3CeJXZHTv3i970yhc3IZxsiL2E5Re5XRSyL0DmWgFBhJZYfwBsNdWwW+UjplNYzqcQZgkHWCjwQ81+MehjcknLMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCAuJECM; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4836d4c26d3so39007695e9.2
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 07:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771859640; x=1772464440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnMSq+iMDiikJ8uyTdLbOxczxYu6EkENQJgj76vUHKo=;
        b=lCAuJECMyvDgF3hi/2NR54EbkNlb+iiZplrNjpUvH0s2801EEeXeodEbB8tcj1rTa5
         2uWs7aTBsTtvMUF083+WXWxmoXwch/dQms44zuW7hJN6bsUwE7JvmW3aViIdktIRuW6U
         OWgNJP0EOG1q892gGnkKVBCsohg/AykxJQF/vnneDiS5qG2aA+O26q/wzDXSP9KT3V31
         KPyCFPm9NZ3+mEotv0vt3SzL+rY8p3HU93Da9QzOnVHRGjir0VXwiRkwo6BE0YsWUOdv
         XS7WbRNJBoic+yA0u88lMGZ6uERRdz8r7zU8LfnpKwGXUErO5WIeoJ7vr4uSBysoV5Pt
         myuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771859640; x=1772464440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xnMSq+iMDiikJ8uyTdLbOxczxYu6EkENQJgj76vUHKo=;
        b=XohxZMJl3FkgB+x2zGGHzYcLybowTrgpa5lzCOUq+OuA+Oh7Ts8aTVwxnyqixUjFGB
         shZKjaTciWhWlKsVqcnSNN+kdvyj7dqMbsj/s4n6zMmVtLo1IceGum1+LaEgWXUi5Ai+
         3XzHCzeiZ1LbXHjW9l/q6A4vOSjbmkEc7dsJ8bDlSuLWPdYj+OamUt/7FkosBLb389fE
         GRDiPqzG6/fjkkmd9bebmLXiUnwRmIkqJhdRMjATkxw9BG7FrpCwiHlGcag5Ig7ds5CI
         ucRXrFMFN+p1NAwwRBpLSV+v9Opu5G8B5X7MpP034VphV3+1Wc7q/zpQXYyNClyCwQL8
         E8iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjpeejf8IBoWjk2XmJoBEU/GKW//igkUXPhC40hDIvJAI7fdVIVzVHy1upnZRNfecOaLKAUao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIAr49ztuLXcB0xm5SfCcRuNDXdBMVtFcanhR/6S0HOu6ixw84
	JaOU4OGrDgDBxBVH5ODay/q+UXOd6dWTqTHj5T9IiFwf1ty+9xLaSrve
X-Gm-Gg: AZuq6aItJCK0lfKD55tp1fKAJPNivDdHUERqKIYd4xhDOlSgshHlWMNHPKmlm2Biloq
	Uk9nbJqWkCGuA0yvI3ivEIzFgq7mtjjBjkvBJS7t4o4IMFXwFqEbNuRd7xyg1OeV00nTSIbpnCz
	tpPGKp/bgRM+px+OPKfZgkYxtE5QuttAk3Okkf+zZkZBInWdz76QnV+7AY22MexZJ7Hvq0W5KMc
	Ag7prvU2EFC6DdrJw51WmY+HueqCVG/D7dfhzvhViVQFo6s759BckAPvb69jKlLbrvjMwGskjde
	AS1O6LfCLmQoUM6SpaRE6As4ygHpxHpSOv4JdEsovy0TFlTGGvTlL9Tsh9k90OIyRdTIOVJNI31
	N9Wcmrlr/cq7yxz+5lMV/iGXOJXUZBYmSm9sg+xL7ugqhmudIburuc/NBV4MIayYl7pj2rF9Msx
	k4n1iGSbqbCs17IRjpxmrLLUL2KW+MzMVQLuUrCHj95LYH7BQ7jycFJwECKEbFbcqg
X-Received: by 2002:a05:600c:3484:b0:480:4b59:932e with SMTP id 5b1f17b1804b1-483a95b58b7mr147817495e9.11.1771859640137;
        Mon, 23 Feb 2026 07:14:00 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9caadedsm166131135e9.10.2026.02.23.07.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 07:13:59 -0800 (PST)
Date: Mon, 23 Feb 2026 15:13:58 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Koen Vandeputte <koen.vandeputte@citymesh.com>, oneukum@suse.com,
 andrew+netdev@lunn.ch, Eric Dumazet <edumazet@google.com>, kuba@kernel.org,
 pabeni@redhat.com, netdev <netdev@vger.kernel.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: commit 662dc80a5e86 breaks rmnet over usb
Message-ID: <20260223151358.0efc263d@pumpkin>
In-Reply-To: <95ccf5a6-975b-4543-80a3-595f1ee20543@redhat.com>
References: <CAPh3n803k8JcBPV5qEzUB-oKzWkAs-D5CU7z=Vd_nLRCr5ZqQg@mail.gmail.com>
	<95ccf5a6-975b-4543-80a3-595f1ee20543@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260080-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 002E9178A06
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 15:08:41 +0100
Laurent Vivier <lvivier@redhat.com> wrote:

...
> It's weird to be able to set an MTU that is not supported by the hardware.
> 
> To restore performance I think the rx_usb_size should be decoupled from MTU max in qmi_wwan.

A lot of 'usbnet' drivers support usb packets that contain multiple ethernet frames.
IIRC (I looked at this code quite a few years ago) some (all?) lie very badly
about the skb 'true_size' of receive packets - putting in the frame size
even though it is sat in 16kb+ of kernel memory.

In reality the driver want to receive the 'stream' of usb packets and
debatch it directly into ethernet frames without going though the 'urb'
buffers at all.
ISTR that would be possible with the xhci/usb3 hardware, but would be a
massive re-write of parts of the stack.
I was only trying (and I mean failing) to get 100M working reliably.
Project got canned for other reasons.

	David

