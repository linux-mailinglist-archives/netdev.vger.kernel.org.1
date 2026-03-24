Return-Path: <netdev+bounces-271065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFhXH2iNwmlvewQAu9opvQ
	(envelope-from <netdev+bounces-271065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:11:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E927930902F
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B403C30783A1
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BBF3EFD0D;
	Tue, 24 Mar 2026 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EFzEjqL1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFBF3DEAD7
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774357536; cv=none; b=L/sPt1S1T5rjU0a6trsDTUEUexuqcGSnebb7qU/ayzCUU/X7c1wIul3OMl1jeybUlkL+gsnYC8ABoYDLw89CPlPpHTUuy7CP//1JUHVpJFCfvCHA7sKhyh/oIGK7bOoxp3R0H4mbC8niW8tCI+QO+VmfPA5382xomyUDJHkM57A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774357536; c=relaxed/simple;
	bh=c5ob8x+63Jafk7vg3P7eaQn2ve59Nggw5TcAv/2m3zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQdokeMRKq5zxfLVKF7VtI13EKGCWO6mUPGZewW7wSMDEwr4eu18sk5We9JpR2khUXtIbmcnCpQa5zNCx9nLlNnWjE5EyugcMNOlanNKU50BxXoa9KEZoa8X+i953bqwpnKphcVaerR1eTAcDUVG62Zq0HmAzpv3Dzq4Yb7pW/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=EFzEjqL1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so37787925e9.3
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 06:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774357534; x=1774962334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c5ob8x+63Jafk7vg3P7eaQn2ve59Nggw5TcAv/2m3zw=;
        b=EFzEjqL1CrH9+xTEQCCpzA5wU2vTa0ZY3RcosBio97hIDcHZBskxxAceCFYxV67SFM
         PsTcBXmJJvz4+0zHWTzSrknsIRvi1p7y9gYNNDPeAy6cBzEUo4GHYGzSilSFRbUdOhBY
         shUTABQWxsLpoSzpCZFYP6G9GqGEMj90LW9rmoQwemQ6I9/otaeFCWu9SP/rKdtOcV2N
         RvyJsoJ+5I/0lFD5fi+ZjIej+CX+layGDTrr9dJUmgQdQVZwYcZafg8XEa/nZSkm45a2
         MXtwhLewzXFRS37telw/QsZrlr9R1w/prdiV7ebHrNdCbRvSWCdfyMihQCLi4MxiZtni
         bT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774357534; x=1774962334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5ob8x+63Jafk7vg3P7eaQn2ve59Nggw5TcAv/2m3zw=;
        b=eJ2kL8zyBSjr6l0Y0alfV5mT2IU2GYctxff40ygfhvVF1vvs5HCAkzqju5OtAb6L1x
         O80EctqDYfBjl7t7yu/OxprJkloBtkikqqHg42XWAeJ8pknkpl0Py3p3KURBReQ4T8cM
         xAGNGR//UBAmjaHNrkZcmTzeHst6mmxR2Gki8slpS7ClN/MB5cbOh2aoHdlkAHWrhc3a
         MeWkBEkC6kuRziG1k64Z6R23Sc9xRGokFx4HfZest4F/pajFTT5rk0qq84MofrKUMjFS
         B0hw1DgwCuo3Y7a+KQ97/SXcyRgq5wX4JeCD9B9SayL4j2ZjhsBPkLJ51JbMJMCzipxF
         5FVg==
X-Forwarded-Encrypted: i=1; AJvYcCXFvNNhq+JkPU7H0295Em6gR8m9N/0xgCJtNYu/6BKDZTn9Oy8jcc57QD8i13Aixq9Fi7vYBXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlg9D6f3lIBKvg2Y9e+YT0J4/OOPqwCYS1ZYXCL4iWtiOOknE6
	zBEFghVUlatca8TvBqyUMVORDUeeYUnUMALZzxoKSfWdVFTNTijYsbcNwsOXCAtIRlIGIZYs0h8
	Kn3X5XcE=
X-Gm-Gg: ATEYQzxsPirCuGh2ZdMDhGZ6LT5m+M3xO9TzMlvicS028DqRgEqhG9OCjO8HxZlVje2
	F2xrzTgQkNyZZ4lvBzneUAAa3JZ/+5Vw0UC3jG/VJd2ok4kvnmzaRP2WFkHhpPSFBu2Quxt1OeZ
	O7ZTPhg3z9G+R7tIv+6FRpv24FsAxVmwEx1e0dE8scwOJV+xfeW2SumAKiCEo4UUnj2hgzan+j2
	vE3uu0ZqCjex0u5aRRaHTq6VfMNuMN20suk0s3Grkp42uzdnSpeAv7A0jKE+ZtPJTVTklXLHoe5
	cOs0rlk5RJ2rr2L0b7r19OsSWEEqMyWk4x3jvSln8Z7/gm0HiKcL1z9mTaUDRFN5/uiyFVZ9FZp
	EJpXa6pysuDzNOVyiPUynLgjJXabrDH8gBzA4S8iWJmB0q8vbTWXnjSUsMZ9B6na2saymejaql2
	QOqaVhpR2JvVDdZR2964KUvE/g0Xwj72nHaiQ=
X-Received: by 2002:a05:600c:4f10:b0:487:2e8:69c5 with SMTP id 5b1f17b1804b1-48702e86a88mr205126035e9.15.1774357533835;
        Tue, 24 Mar 2026 06:05:33 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48710fa0e35sm46182275e9.3.2026.03.24.06.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 06:05:33 -0700 (PDT)
Date: Tue, 24 Mar 2026 14:05:30 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, 
	Chuck Lever <chuck.lever@oracle.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
	Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, 
	Daniel Zahka <daniel.zahka@gmail.com>, Shay Drory <shayd@nvidia.com>, Kees Cook <kees@kernel.org>, 
	Daniel Jurgens <danielj@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Willem de Bruijn <willemb@google.com>, 
	David Wei <dw@davidwei.uk>, Petr Machata <petrm@nvidia.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V8 03/14] devlink: Migrate from info->user_ptr
 to info->ctx
Message-ID: <yfpepx63i2om7y62kspzizq7a3xxknfnzrg7j27ppt2oxpeou2@kfbomamxpdo4>
References: <20260324122848.36731-1-tariqt@nvidia.com>
 <20260324122848.36731-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324122848.36731-4-tariqt@nvidia.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271065-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,davidwei.uk,fomichev.me,linux.dev,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: E927930902F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tue, Mar 24, 2026 at 01:28:37PM +0100, tariqt@nvidia.com wrote:
>From: Cosmin Ratiu <cratiu@nvidia.com>
>
>Replace deprecated info->user_ptr[0]/[1] with a typed
>devlink_nl_ctx struct stored in info->ctx. The struct aliases
>the same union memory, so the migration is safe.
>
>There are no functionality changes here.
>
>Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

