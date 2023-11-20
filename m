Return-Path: <netdev+bounces-49410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8D47F1F2F
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 22:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0D01C21032
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 21:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61EF38DE6;
	Mon, 20 Nov 2023 21:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="hFykOVTU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13D2CA
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 13:30:40 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-280200949c3so3270984a91.0
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 13:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1700515840; x=1701120640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5q0EYm+eZI0fgXpCenD8K3w2uKG3crMC/aZSxiYVRo=;
        b=hFykOVTUtbrmYJCfU/EsePAlZb/dtC+RxqRG8agzww1BuCEeOI01kQibvmO7/MOcpM
         RLv2AUx+KRsWvBAFKodbTGhDgYl3Pmb73KRW4vqW+KmEH88PPB85hdXqCH7PDnthB23h
         VL3z+dU5d2ezYeOMG29UT/FGPA56a+ye1k1joze6j+ncHpbGNbBL4SozNHct/ksxO/uN
         nkVPBfiuC4cqwljGxTubTJambqqbSFWVoEGD5PA7J1FNbBVdXQnSMgmLQ/3kJReeXqFr
         fzlM9PuRR6KqX5Dkd9H8kRRFjrUc6TEoVMFseElWo0dxRwssa9q0FpZk1ZX/Dq7g+6Du
         Lzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700515840; x=1701120640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5q0EYm+eZI0fgXpCenD8K3w2uKG3crMC/aZSxiYVRo=;
        b=DjEd/W6MmO/bWcbEKf5iEK1PMGAfC1Zy5liU7WjA9Bo3CKyKfE3+JYERnJod0re//2
         JwkXWYxtZ5a844+lMAFdbwDgV3zseHJ3Tm5EPsCbPW209um6td3JcbAVr97yEfnnrxxf
         +IHwNND54PhIQaqAAtYZRi5c432avGZiEXwhK/++2QgQ7HiZXm5ctE4No5vsa0kAciYu
         ZzBfH4aRdQg5DvYpFgYYAoVNESBk3sc97vjJSaLOgYfflfX46Y3MtGsMwGtd4LYPnkrM
         dYdv6yGFwcR8HsDR4Nff9/iLqg8glZZ30o1Bth/So13dWhyqzpq3Ll0V8wzctwxDBrCI
         YAuw==
X-Gm-Message-State: AOJu0YxnRMETUUyCUSsC2ia5GHMNS1VoKn/4W3/R5qfNtDIOe2I/0yQT
	6KKi7VuagaDYjWUVvTCLgZ9YstCfO8J7EQCMaDY=
X-Google-Smtp-Source: AGHT+IHSeawXByu456oZ+QXQfTrI61sinCpo0L4LXFTpLT0RlCbdk+UqZs47FbOWh5anZXhSW0C1+A==
X-Received: by 2002:a17:90b:1bcc:b0:27d:75f2:a3ee with SMTP id oa12-20020a17090b1bcc00b0027d75f2a3eemr6240853pjb.10.1700515840043;
        Mon, 20 Nov 2023 13:30:40 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id p14-20020a17090a2d8e00b00276cb03a0e9sm5838161pjd.46.2023.11.20.13.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 13:30:39 -0800 (PST)
Date: Mon, 20 Nov 2023 13:30:37 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: razor@blackwall.org, martin.lau@kernel.org, dsahern@kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 v2] ip, link: Add support for netkit
Message-ID: <20231120133037.7b86ec78@hermes.local>
In-Reply-To: <20231120211054.8750-1-daniel@iogearbox.net>
References: <20231120211054.8750-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Nov 2023 22:10:54 +0100
Daniel Borkmann <daniel@iogearbox.net> wrote:

> +static void netkit_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
> +{
> +	if (!tb)
> +		return;
> +	if (tb[IFLA_NETKIT_MODE]) {
> +		__u32 mode = rta_getattr_u32(tb[IFLA_NETKIT_MODE]);
> +
> +		print_string(PRINT_ANY, "mode", "mode %s ",
> +			     netkit_mode_strings[mode]);

What if kernel adds a new mode in future?
Probably want something like:

		print_string(PRINT_ANY, "mode", "mode %s ",
			mode >= ARRAY_SIZE(netkit_mode_strings) ? "UNKNOWN" : netkit_mode_strings[mode]);

