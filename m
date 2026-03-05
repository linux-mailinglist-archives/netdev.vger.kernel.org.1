Return-Path: <netdev+bounces-264322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEppA2lrqWnH7AAAu9opvQ
	(envelope-from <netdev+bounces-264322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:39:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E09E210AFA
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36209300FEF7
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 11:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08673391503;
	Thu,  5 Mar 2026 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWFvqa/N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457971C8604
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772710752; cv=none; b=WLCPIzUbbrfEw8zCIut5Y+Q9QLTI0WMwq3+PRFzZq+pCSL0VSL709fXeQv4fAkJ/FENAOmjxoF6W6Xv9P+mNmoYIKbiZhQ+0itR05QEHYxW3D1eyHc2DstkXShM9L0O+6yU+uoW/nzj8+ruQPEJTE12rVhip4CejDnbAdbL8xok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772710752; c=relaxed/simple;
	bh=S5LZsbq68zRC+8LnZWu/3s3cygvK02fdVVdEX4Rniko=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=NFWI9v79+Hnb6BtuUMHLMAI4muDLE3oV0DKB2PvruSUgAK7VYmHULpNUIqQomBF+lVXraM2Lo3MjopT12nt01QyrQ38yRA5CgqnEPrD0kWczHGkDBXeen9QCDb343Aynh5P3p5rfMP3dcFNQ7lR28+Amp16i81b6Lmoc56l2aOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWFvqa/N; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439baf33150so3335331f8f.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 03:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772710747; x=1773315547; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pten5Ypi8vG/Cb05nbSIjn5/Tqb5Y594tzKSHjioPpY=;
        b=nWFvqa/N9z0MsjoYHhTPggsKnsV3IAh8ZywSiHt47aRQDP8vI1CSx3HJd4Kmbz76m/
         dR0GG2xJ6mNVjWtMmWibVpjGd6SOSeeQMfl7Xsg/CyQLGrQIvm21N+oBtpwFoFo+Ar0h
         OvIsjmMgXVrfq+1ZM5k9xVvEhH+mGkO+mkG2CCZQqeXDOesEZ2so21fbdvTqOUvgCrYp
         mDMmtMtKzHmGxjQlw+tbNsHQtYCVDNC9Ojp6ZcyPl4iCQhFzQVPDX8lF7eOsNk25k0MB
         q0rAJdfcWjyeFu+7VMMVK6t8khd0FkSKFH3U1vN0itHzLuwf/Mx4W0qRMu01i/MZFvCw
         2ZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772710747; x=1773315547;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pten5Ypi8vG/Cb05nbSIjn5/Tqb5Y594tzKSHjioPpY=;
        b=ATgCkRRh0NegVFZnQslky7Gpgjh209Kdg1l5OeOZAG4dvvzxLGY1yEjPgVjvD30pza
         ADG1XGdMe1yO3n3G2gGohb8zP0Z/T8TM7qSIy12etRQmwTegW7T7G2P+tClXX1vETeI8
         dPpGFZBr30x+xGQ0b9A3/nwaTKdA4AYeGhcl9ZeRhlWMzTOSPOp1EQOBj1fgVwywPbzN
         qLRkbJhtUHA4DkASRZ9++RsvYN0jYkaRKvNTJ8296Z+9ii68NiOygU6hMz7lPgz5HNzx
         LKuNXiC0fkFC7NX2nL0Sdk71MlaffKyHgm/YGGNOafLhXowHqTbE9SAubE0WM6RJtKQS
         qVCw==
X-Gm-Message-State: AOJu0Yx0xSJDan6uPoV7MtjI9yJ8LoX4nbCs7r5FKA1bfywlpN6usltF
	h7RCGfhfopwX2jsd5HiQkmzrDNzpz3KgC+ZhYNLxuKL7OqD0cpYTCnIl
X-Gm-Gg: ATEYQzwNTgHM2Rv5mcVyEMrTi1158FwcnSpeKYL2F/7TPuvNZvPzsIsZeImzLKTVflB
	Tg3ls7y381s8fC9LGgF3nt4DHzLksfjPdoi+5mOFof/iz4Q2tv7XRdDcsEQQYOnQpdaPWYvbWiv
	/21FDCLFIv7AK84m3NPxFjAxE1cH7ZZyRuqmI0LTeT1NEqqIumb8NwEDKoaMp30f1fPzvgGS14y
	/o+3ylp7Mqw9E85aDCeNz3p58EhsPH5A/umMjBCUBoss1EGz5ZpKKgOnO97X5Doa9xWESbFtV8Z
	JGyVORTuBM5+N5JkNWTqjtwHHR8iahXDHjRZixGrySCyP/lUd5zrfg7xphjpYPP3g0s5WIZxM/4
	x7Kb4vYvi5z9mdKPQS8Za28F2rO5FlOuMkv2xJxVKru7E8mbqxtNg/09NQTTatJbqVNLczRG8BZ
	Iae2qCFhlxJ8KFY62HdfsSc9jSBA==
X-Received: by 2002:a05:6000:1a8d:b0:439:b79d:b9a6 with SMTP id ffacd0b85a97d-439cfc2e4d2mr4000940f8f.11.1772710747239;
        Thu, 05 Mar 2026 03:39:07 -0800 (PST)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b4175fd2sm34864533f8f.14.2026.03.05.03.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 03:39:06 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Antonio Quartulli <antonio@openvpn.net>,  Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  Paolo Abeni <pabeni@redhat.com>,  Simon Horman
 <horms@kernel.org>,  Ralf Lici <ralf@mandelbit.com>
Subject: Re: [PATCH net-next] tools: ynl: add uns-admin-perm to genetlink
In-Reply-To: <20260304141020.23270-1-antonio@openvpn.net>
Date: Thu, 05 Mar 2026 11:36:50 +0000
Message-ID: <m2qzpyik31.fsf@gmail.com>
References: <20260304141020.23270-1-antonio@openvpn.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 7E09E210AFA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264322-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,openvpn.net:email,mandelbit.com:email]
X-Rspamd-Action: no action

Antonio Quartulli <antonio@openvpn.net> writes:

> GENL_UNS_ADMIN_PERM may be required by protocols using
> the `genetlink` family, however, this flag is currently
> only allowed in `genetlink-legacy`.
>
> Add it to the list of possible values in genetlink.yaml too.
>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Donald Hunter <donald.hunter@gmail.com>
> Link: https://github.com/OpenVPN/ovpn-net-next/issues/33
> Suggested-by: Ralf Lici <ralf@mandelbit.com>
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>
> As described in the linked GH issue, we hit an issue with OpenVPN
> running in a user namespace that was unable to send netlink
> messages to the ovpn kernel module.
>
> After checking how other modules handles this, we saw that we
> required the uns-admin-perm cmd-flag. However, this flag is allowed
> only for genetlink-legacy protocols, which ovpn is not.
>
> I don't see a clear reason why genetlink shouldn't have this flag too,
> hence I am proposing this patch.
>
>
>  Documentation/netlink/genetlink.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
> index b020a537d8ac..a1194d5d93fc 100644
> --- a/Documentation/netlink/genetlink.yaml
> +++ b/Documentation/netlink/genetlink.yaml
> @@ -262,7 +262,7 @@ properties:
>                description: Command flags.
>                type: array
>                items:
> -                enum: [ admin-perm ]
> +                enum: [ admin-perm, uns-admin-perm ]
>              dont-validate:
>                description: Kernel attribute validation flags.
>                type: array

For completeness the flag should probably also be added to
genetlink-c.yaml since:

netlink-raw > genetlink-legacy > genetlink-c > genetlink

Though I see that genetlink-c is not actually referenced by any specs
today so maybe we don't need it. I defer to Jakub for guidance.

