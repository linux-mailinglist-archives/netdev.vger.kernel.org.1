Return-Path: <netdev+bounces-285261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EgDCKBy/GkEQQAAu9opvQ
	(envelope-from <netdev+bounces-285261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:08:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D28D74E73C3
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 172A13011A73
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBF836C5AC;
	Thu,  7 May 2026 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="vjhgEdP4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9113382DA
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 11:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778152090; cv=none; b=VwdvUst4RalS8zEBNWk59MMYqkkERxMJrmaQKD0ApM7Zx4G+btyYqVvYF4UFHG17Lbz3sBpQ70NxnFmISp/GO4QO6zpPrqIRHZtdyIqk70akf+WtN3XzVWlUfPzYnUz+A92kKgBRKWYs+s9SUT1zwODv4sZPOe2myQ6W0X/mKIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778152090; c=relaxed/simple;
	bh=Nsrc00XMPyX354SuXe3nqx7fE5fihqR3ZqDdgpTbxkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufCjZZtxI6lC7onmN/KNUUYZQgX+TZmsr+WmcykcA+hqHmbuhmUoap8Z0TLRDb1+LxW547pfhOwaoX84dnhwZCZHl/ZB/Wcf/HeU05hHc+a8F+aoTEJUy4Z1vJ3D8ceTcAQOSJMozzV9MogJl9jq62U7iZpFdpOj+Aqbmi4vUDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=vjhgEdP4; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43fe62837baso381908f8f.3
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 04:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778152088; x=1778756888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kgrq7ox95689Ig8vha0xiBqXHGOC+ZuPbRsEee974HA=;
        b=vjhgEdP4XA6KSiKerw/89U6Z3XXtAo8tQ78KeMc9QWmjVF4e6YVKYWxt5tYkBJnFaU
         P2zcDqAQdZfRk/Z3MbZAi0Ypr6nkx6IzwgYMAvy7/fwPWXFSV3eRc5pT5bqYyLlofl8O
         uq8AnIAklk5MLvi6DQeEEtPXtnmIDL8dr8HADz2DAhE4QRJl7Iv3gjmHWJfwzn7QBzmx
         FSwGSsV26p+a2GVUXVjhGKFT7c7igFfu/FIn+sObWqLJw5M0GU+JqBwkWwFjd/gTCJmm
         mxT7IX3+uZKfWeN8x/7GjGrUlY3eyiJceB65Soe39Iqh0l+FPVIhauFzr/o7oL/G30lA
         GBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778152088; x=1778756888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kgrq7ox95689Ig8vha0xiBqXHGOC+ZuPbRsEee974HA=;
        b=Jg3fDmk7q0qli24lF1vuf8tgKVSPmIeucI83AiORFgl7gUYBGHCNqAwGUHysVLOpSx
         nAoqe+hr0kGA8MAYr76ew3uDQzCA+Aoa3lLqiQcoLaPji8w4zhScUrudL30+ABt59AXv
         c4hAxFdWuPkyA/jvUN4tXPVy9kio4sfevz/R1jzNfuMptA0i7z07YUIzoD+1ylFvdQKT
         T15F/NSlnRom+g3/Y3KtP1xGO3tPYNffkO1y3QozmZ7E8YEbapZr1G1F/ZxfMFPA+A92
         QZlyKlh08ZinBne82cNM5Zs0usSCWqT58fV2vkq8U+bAra83L58oGqsu0UfUe6+bhNXL
         gcHQ==
X-Forwarded-Encrypted: i=1; AFNElJ8HoD00lmZUwkpWWDkfU1DIcft71lEeMzUyMtXS1cyDXq8LfxANa2BEkTiXbtBWk47jXk4HHw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2nGxm6fDBVYZruoFvmIgrNWcpKD4IyjVdShNd8AaDuYch3QZc
	JPxyjmZA/uoU5czniQPzfPGp4kbyENppI+5K9tju4uBQW/xV02Xu4duSz0Q4yA9xufGosFTvs8g
	ncqEMxYM=
X-Gm-Gg: AeBDieugYVO1HSOJEbVA4HO9P2d1VX4bnhTcb4c7Ip/Yy3u6gS6LTfJz9Y/OdI8iU57
	7eu9lrkJLWjZa48ZfRTKJxNClqaNPylUplK6RSafA7RHhitJTkA8I61aVAJ0Ev01hGMZ9m/FKKk
	0UhpJU6lZ2Vf3ApaCD0ilyL0suEFR2KYY8loP8cwk6Ph7IQ1Y1ihZpuIm5KLaBa7s/1UgFl8GOD
	YsjTaBznnCjfS5ohVzHwVr0IIAWoxfBz5ileQn1QQgIHsXWUud1suvHbjOJDd6GCSZSgemldprm
	ifmmAj5tmS3CvsG3kJXh6JbrHZa2AbX61a+0d2l8I8r/0P8+YpCny9nKl7jnWxOIaDcS/lIt2Nw
	vufZGjYh6mgwGX5l3PzErQEKZsphlGANMB2tUMqRgV2XM5A5TYDBViLEhTnYPkYC0M7UMUdqK7o
	y60XhTOoRWCqcQupm6CEB+41bN5h+yVS9SXfwMVqE6Arvd3LhDxND6KA==
X-Received: by 2002:a05:6000:2c05:b0:44a:aa3c:5927 with SMTP id ffacd0b85a97d-4515d5c69b6mr12915400f8f.29.1778152087145;
        Thu, 07 May 2026 04:08:07 -0700 (PDT)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:6064:31aa:7680:7221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45054b02abbsm18552017f8f.18.2026.05.07.04.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 04:08:06 -0700 (PDT)
Date: Thu, 7 May 2026 13:08:04 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, 
	Michal Schmidt <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
	Pasi Vaananen <pvaanane@redhat.com>, Petr Oros <poros@redhat.com>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] dpll: add fractional frequency offset to
 pin-parent-device
Message-ID: <afxyKwzMcnc4AEu7@FV6GYCPJ69>
References: <20260504155340.411063-1-ivecera@redhat.com>
 <20260504155340.411063-2-ivecera@redhat.com>
 <20260506183342.767b5fbc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506183342.767b5fbc@kernel.org>
X-Rspamd-Queue-Id: D28D74E73C3
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-285261-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,lunn.ch,intel.com,davemloft.net,gmail.com,google.com,lwn.net,kernel.org,nvidia.com,microchip.com,linuxfoundation.org,linux.dev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

Thu, May 07, 2026 at 03:33:42AM +0200, kuba@kernel.org wrote:
>On Mon,  4 May 2026 17:53:39 +0200 Ivan Vecera wrote:
>> +          At top level this represents the RX vs TX symbol rate
>> +          offset on the media associated with the pin.
>
>Isn't this a hacky hack? I'd think that pin is in or out.
>Having a freq offset between two pins or pin and parent's
>ref lock makes sense. This new interpretation sounds like
>we are trying to shove a difference between two pins into one?

The pin is in, but it is associated with SyncE port that has RX/TX
symbol rate offset. As the doc says, the "offset on the media associated
with the pin". Why is that hack?


>
>> @@ -299,6 +299,10 @@ zl3073x_dpll_input_pin_ffo_get(const struct dpll_pin *dpll_pin, void *pin_priv,
>>  {
>>  	struct zl3073x_dpll_pin *pin = pin_priv;
>>  
>> +	/* Only rx vs tx symbol rate FFO is supported */
>> +	if (dpll)
>> +		return -ENODATA;
>> +
>>  	*ffo = pin->freq_offset;
>
>It's easy for driver authors to forget this sort of validation.
>We should fail close, so it's better to have some "capability"
>bits or something for the driver to opt into getting given format 
>of the call.

