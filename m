Return-Path: <netdev+bounces-279022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIcZKaPL4GkdmAAAu9opvQ
	(envelope-from <netdev+bounces-279022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:44:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6585940D9A5
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96B973094B4A
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 11:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880A537F01D;
	Thu, 16 Apr 2026 11:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="jc4x/YjV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C283A0EB1
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776339826; cv=none; b=X2q3YJW2sCMoU+T+DHE7W6UkmcuBPMedlSqRfzKFEbAQPBcxOF3MhFO8oZ4dqiLzGPVzVQG2TGWV42l2ff0KGrfjQMe1Gxxrrd1shgFnebrRZLFG/1oUi4U86BZD2kI4befl+2YlJ5+QUoTt2LwWhWFMkaej9hIcJ7pOo8ktRnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776339826; c=relaxed/simple;
	bh=LiW4y6y4EPEmevKk/qB7ftJM1ZnjAOFAMUw1ot+fC8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7NEwgDxikU68BKTsfnctbK2cGy+JAvcHY4S/K3jId9JOpvr0QlLe0i3/MV+udre6+lKxoTfo7qBMJ7yksEhZlOR/7SZ9b5LlEUq0zKfkS+ce+LvnhKy+bKVvmUvxqLPhkFzZrn+2QS4Ka1lOnVSwrOEBcfsQxUi5v5gimhA2GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=jc4x/YjV; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d7213b6ebso2897194f8f.3
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 04:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1776339819; x=1776944619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y+Fwq2OQSz0NDX3k5uEX8j3YvfXrtK+Qwqa12x5RwGI=;
        b=jc4x/YjV3sK9gfvq7nZ4x3HiEzabtBqMUexaFbe6GAay6Tb1lbA8+A0yuqIGdVBHs9
         gyqumhTXzJS6OKHgOR7npEYPkJv9xozGse3bIgNICQDgo6jE9miFf/2XX3VzqvVy/1zN
         BA02MwYTQl8IHOqXSFNJS+lhNSz6zurqfiziTJTbMrN3nzqH37g/vOahJrmTn15WhYaB
         o4nl2Lhdn86ZC7XZS9r2OG89DBZXC9kJKt1SFPLqVdcTqeU8DrtYUpu2PGLNwipmo7gA
         A29q2puQSG+HMj6+yFY7Sz8zE1Tqrs5PJLRRCv50QD5p4TzTWdabkCMxgTku2wOu4BnX
         yrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776339819; x=1776944619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+Fwq2OQSz0NDX3k5uEX8j3YvfXrtK+Qwqa12x5RwGI=;
        b=iXImOtnW7hzbF2e9QiujVP40DIXbbRis23jBTz5aLyXVDfNboFvfwIY+4HhTCjFx01
         92ff5oSUDZZQR2pazTkYEiW1llXsAKIaya+CJDLYIk/QXtA53zvgeM1zHG6c3EvLc401
         wkfaoVViMH/I5QO/uwNVZCkR3+g9N8pbTu1cJ2OfzBpHgeX2i84XPXfLdfPYa0Mz2oU7
         rDkyIT5raE4XOef+GSaKQ2TrJAj81CInLaQqLP2ks1elCbTWlotB4B692rDrRH0W+mW0
         QFzI92Qg7TToABI1/nWjQ8IfyVD/spcoIYliMEWw5jrX+92jCjGqfghXQ/17b/E+S2e1
         ietA==
X-Gm-Message-State: AOJu0YxNcNEqNiPyCxreqADnNPUUHEeBUfDKE66xnHY4s17oqrdM4j0s
	oLk52g5nYfUC7Kj4IZqjr0UvQmTQllLonAsf7BG9QJG/A3JIji0RlU39IVV0Tj8XLdk=
X-Gm-Gg: AeBDieumAB3fAcyHcR8sTMmNeSbZeTpV5d1onhMCGUXUsifkVFfjIPPipS/8f4g0Dpn
	Dt7NfjKhZC+C0DiRNhRc/7vGKty7YXW3VJ5H1fTmCVnz2Myum2bNr8plQor7i/Wjv6Ew4hVCm43
	H/u5o/X05rINgfeNvul70OxAT7NEt3Qdp1znAHQwS6wK+JXwbXor4QWGR0s5+I5aAwg2aFEX9BQ
	khdD1WzrN83Zrf5PB7YW59kd/RFmlNN8enULIjwDL5Ye1UiXWYNVU7dRpYMMdxY5C8r1NxXyUQP
	JYGV/DVTreMPfq5KKS8zySXbaU1YPcyjfWztt3b7qaxRoWIWjlwlMzktB3miFXQPvaH3AYo+cox
	icqJ9bDDfAHLPKsANTFICn4yxgNNypv7RUWphBnGY40yTr7ZbSMkXA8ZpeggLlr9QOaF3jL4xsZ
	ZP3vUNO0OuASy553eBWywdMIQIUUBHAlR1aw==
X-Received: by 2002:a05:600c:3f0a:b0:488:afb5:6a21 with SMTP id 5b1f17b1804b1-488d68764b0mr351693715e9.15.1776339818549;
        Thu, 16 Apr 2026 04:43:38 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f08b960esm72542545e9.0.2026.04.16.04.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 04:43:37 -0700 (PDT)
Date: Thu, 16 Apr 2026 13:43:32 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Ivan Vecera <ivecera@redhat.com>, 
	Rinitha S <sx.rinitha@intel.com>, Michal Schmidt <mschmidt@redhat.com>, 
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net v6 2/2] ice: fix missing dpll notifications for SW
 pins
Message-ID: <gpjn22psgdvoavp6n2npl5k4i7gp5vxniwrl47gvycfptmjdqp@rl76aletywq5>
References: <20260416113952.389405-1-poros@redhat.com>
 <20260416113952.389405-3-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416113952.389405-3-poros@redhat.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279022-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6585940D9A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thu, Apr 16, 2026 at 01:39:52PM +0200, poros@redhat.com wrote:

[..]

>@@ -1233,7 +1259,6 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
> 			ret = ice_dpll_pin_state_update(p->pf, target,
> 							type, extack);
> 	}
>-

?

> 	return ret;
> }
> 

[..]

