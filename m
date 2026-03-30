Return-Path: <netdev+bounces-273182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SK7DBHl6ymnk9AUAu9opvQ
	(envelope-from <netdev+bounces-273182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:28:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAF335BF5F
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9553F304C96C
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707273D4101;
	Mon, 30 Mar 2026 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="m1dER4mf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0AC3D332B
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876763; cv=none; b=U69PLqUxTQmWe8APU8Djb8z+RMN3g5tHhPGdM/XGvPCtBkaBKITbXQP53SBZOxULcsuKl+LNsLxF7Nn7pBey/crWwPGr2ytFiZ5bcuvaHNVyxcFfztGCFlz3VEEy8WDIFvMPeKPpbNx+G17w1ZyDlIbs5m9j2lES5kDLoILFgNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876763; c=relaxed/simple;
	bh=EY1uHNY3iIJ5cihz+6so5yFVS+lgzsWO4IR+TkXuznI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsAb871wcVIK9Wpn9a3yVrRQyV339pTbU9teD+KHmgKMDit2nubaGDYujRI8G1w3wWt8m6vyZfv+wjtq8sdWgkKjkwGvhLyEv710fF8bRTR4mQ8OgHB/5iicyPh3DyoXRTzZEloqZjlgPweFfKJV/5R1iy2s/v2z7v0Pua9pjkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=m1dER4mf; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cf3ee0fc1so1146998f8f.1
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 06:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774876756; x=1775481556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pMalXmwdVcgJVkGoRgzor4D+1K1bGfwbUwF3c/D+FzA=;
        b=m1dER4mfp7IcbO6FO6ZlBJlz7tNCeu9dq0HMpuphXFBAWbzVTAfwk/ACwZwm85nkJj
         EabBKc9j2eQ529pIp6ec2CyY8CWRhWBOeXSs2bINCchXimUQaBow2kE0X2K4kfYME2dm
         lLbm8AOauDE70h4hrljs/etiGlBmVC6akWd0jyMGUn9QI/WbhqeE/DVffGu02+rfenHW
         /pvsGlR2xNV5YvnVyEK8u9NQslCIJjcQ2CwXiCAfLYhwvbGJgCGJ12QJ7Y3NgsxqCxBD
         VrAWBET1ok0bGKGU3u/x5mlMTGBQr2z046XbikHyN5KLtbvh4kcRLXMVy+kzur4hZjWe
         joOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774876756; x=1775481556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMalXmwdVcgJVkGoRgzor4D+1K1bGfwbUwF3c/D+FzA=;
        b=iIB53f/jwCti3gul012+1BCWmGVHsO0fRM43+C2FjshHYv1Awkw9jN3AqAzINorr+q
         s42cnGXhEuD8E7zCwLhfPb7yxwA8szGHEtUfRCd3u0YN+HRd5RdQA3ji4Zb5lsUHUwnO
         vRWo2lTYj8erb+OjqfR2uCjQ6oOstfuWIFZPRyAor0pQFRjnG0zHsC97eSTIGgP/gNep
         IgoC/6wKDkD2xtx7L83yPBFCp9FaCcb7y9bTLf5WpPavx2eR2GQaYddqCknEP9cqDVtC
         mpbyoEFFApy5R2UYuveL9441J0ahDW/OOQJO6ag33EIgwSK/vvWl4xdxuWfPzSMKqh1h
         CgXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpOpNU5Q5D6DNf6xrXG9rzkHiXk3Gak0x1LpfecUKDP9Dbe42nuQo6Ym8s3eMEmiVdqKbnmKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgMI3Cbl1uCawgWCvimG0XyafD0LAnxNtUpU1mahbqSkykj2CK
	unOGbVPVzUw81zvdyuQLiF1EZGW/3NNLPsswfW0rE7xerM1YpIyXn9dYPbtwQ2kLBl7gkTl7NJo
	nKwm2
X-Gm-Gg: ATEYQzyO+tBC75vSGAHbbg3uNj6Y5tVjIrE/izoe/IKJj1sUJCSEjfsDnHT4+gULNwe
	v/hBrGw72jJphr3I57BSAh0xqncKiRhzX4VjzKuYNfMb033aa2jsWzECQP6VGtTqope6jtlbvxg
	8RqUeJPOkn3N7ieshdcKqmcVI3KZ1YvljNfEqfXL6JMK2uI+iUs1LoGzGtTInDrdK10g+iDfljx
	2KMYzPRRhQ1PEz6iO6SQuQ1zP2u4yRb678e1NmbOH4mv5Rm2iNDNhu7uOIl5c1pSctG40X85p0k
	nY5WgewQ4DgPXxICLoah4Vylp/iSa759pbtT06h4h00MIjK83SCWffKkIhgrzQx+UyRPXcG7v1K
	G1ZeNx3kZf8Dk9uZzjSmlXncnblZeY8oxxrSUelhw3O8y5thVn6KfTsSOHFWt9Az54NdM81NWGv
	CRgXNvGYrIQhnpkYN5U8R+uKX4JsrrtyL2QYDPmAFIL5KSDA==
X-Received: by 2002:a5d:5f53:0:b0:43c:cda2:4f2a with SMTP id ffacd0b85a97d-43ccda25038mr17299504f8f.4.1774876756332;
        Mon, 30 Mar 2026 06:19:16 -0700 (PDT)
Received: from FV6GYCPJ69 ([213.195.231.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf245f8a3sm20359993f8f.24.2026.03.30.06.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 06:19:15 -0700 (PDT)
Date: Mon, 30 Mar 2026 15:19:14 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Mark Brown <broonie@kernel.org>
Cc: Ben Copeland <ben.copeland@linaro.org>, jiri@nvidia.com, 
	netdev@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH net-next v4 13/15] net/mlx5: Add a shared devlink
 instance for PFs on same chip
Message-ID: <pv3qz7igmifdsoe3flh5fc7n3sjs2suxrh355xp3dm5xx6nkuq@c64bdhxz7of3>
References: <20260312100407.551173-14-jiri@resnulli.us>
 <20260324151014.860376-1-ben.copeland@linaro.org>
 <vms2w2ctvoojfqm25hkqapeq7gvn4bsybnrj5rxwsuvfbwutw7@4i5pbtckvlqn>
 <CAL0q8a6OXJ8qQYYYDCfAdujrsJ-QPt75kB=YQ3rwdZq5L=eO5Q@mail.gmail.com>
 <4cc597da-4742-4437-93b3-686124396517@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cc597da-4742-4437-93b3-686124396517@sirena.org.uk>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273182-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 7DAF335BF5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mon, Mar 30, 2026 at 02:40:08PM +0200, broonie@kernel.org wrote:
>On Tue, Mar 24, 2026 at 03:37:20PM +0000, Ben Copeland wrote:
>> On Tue, 24 Mar 2026 at 15:21, Jiri Pirko <jiri@resnulli.us> wrote:
>> > Tue, Mar 24, 2026 at 04:10:14PM +0100, ben.copeland@linaro.org wrote:
>
>> > >@@ -33,7 +33,7 @@ int mlx5_shd_init(struct mlx5_core_dev *dev)
>> > >               start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
>> > >                                                    PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
>> > >               if (start < 0)
>> > >-                      return -ENOENT;
>> > >+                      return 0;
>
>> > Okay. That is probably the best fall-back. Do you want to send the fix,
>> > or should I?
>
>> I will leave it with you.
>
>Any news on this, the problem still seems to be showing up?


https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=b8f9410aefc15e55304788b958a796d22bcabb7e



