Return-Path: <netdev+bounces-269113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eETrB77XumkycgIAu9opvQ
	(envelope-from <netdev+bounces-269113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:50:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A08E22BF9DF
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13BA1315AE03
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451E23A3811;
	Wed, 18 Mar 2026 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ue/rSA3b";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATIBnCcM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558CC397685
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851635; cv=none; b=qofa+2nfjuJLPQEXEnj1Y4GhsjsMM5vQwvl4mJDjdyNfPmyhAe1U8FZD/xjcf8xcW9bOwlT6KolfXdDv9nZLgcVyyo4M/0g+P0q8HfJf+vEfYMmc83DeUr530JndPw/CiFLE/qPrYFUsOwgaflTLWYd4HF+HkKkzgoTqwVWpF4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851635; c=relaxed/simple;
	bh=E4dO+nFkO+AUhJdebwNlRLK8M4U8yFz808g5pItGZ8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3XvPVrMiwn1BkNM3sv2FMZGTgUkUMWILj8SMU7LebFbU7KIo+EX2xAMU+svYgOq/+X4+7mxGWcvatKravF2O5ixPwUAL0LfEK4gGOn7fSncCXfs4IIk9UI4V/eKfDOxaRmhLwZkE6qIobSOGoIzYPn/up0A2T0f9J7jFEsreUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ue/rSA3b; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ATIBnCcM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773851631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xAk8WW9QfDu19fvP443pClPi2t2rMOGh+AcFYEU07kk=;
	b=Ue/rSA3b4WqajDSLfaxDvgHooIowHt/TMwfrzUvpus0zLuarHZELZXqPSvtsVYl8E7DhB9
	k5gJliX1/eZW4mGHhQZG8v+skeB69Q7jbaQwiFAlOM9Zaqdkco+i/YOoeLmdRoanzew6+U
	j30H5IbIsV3IgcIGZhgf8h6d/IqddAI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-j1km6rmzPIqRmppvh5EOew-1; Wed, 18 Mar 2026 12:33:50 -0400
X-MC-Unique: j1km6rmzPIqRmppvh5EOew-1
X-Mimecast-MFC-AGG-ID: j1km6rmzPIqRmppvh5EOew_1773851629
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4853b5b0fafso334355e9.3
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 09:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773851629; x=1774456429; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xAk8WW9QfDu19fvP443pClPi2t2rMOGh+AcFYEU07kk=;
        b=ATIBnCcMTwoRx63jjcYwtjvpE7d4spHUYNWsvebzlbLu4PZDeOP1jXknpDUINL+5nc
         RCTpAaGuB96++z0RFjn/CRQ3wa2ntC5Wg4MxNPI5HgVddZxtijrtIcTe1iDVp12Az6UD
         M+LLZwDEQtSRuqv24OyJe/hPIWvrSBNvvKl+uSl2tBhPQEMWe1+m7nFO8gbpzLvkZle5
         aqcis89b2lVSCtQjXJvHaBKQgrik0dHMe+nE6Fo119d5VF0PZWbyAXWAREAb+hWKqAv/
         tdF7q3gvkbXv0FDzBI1yZbue36foCmF54IBzknLdecrSOG6xiNe3GtaaZUQYhsSm4xvB
         kU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773851629; x=1774456429;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xAk8WW9QfDu19fvP443pClPi2t2rMOGh+AcFYEU07kk=;
        b=oR5rQhu3XHi5N72fwJlwZ/2yw/Seg++tjmbaWrki1T0XE4dMtTtq4RyFAfWl995XnD
         ZjKwq+ZVr0PrHXZpxX+2xyH02YM4NNcs8lQQpzrVxfyrgQHZVnpA39h9oigLcWeTqEfL
         b2xtQ6RrcoITueQFG78YMpWLlDU6YDUYCIEdu7wSAVZwbKOn+8NMb7TzlVOn9t86biws
         4p47/wIsp+joRBw0BEBgMODBWzKZ4X+mTcg+mr4mTmQEWocsq+kQurz1yTce/ePDM911
         18uaI9Ayc5KEnYSAHe7FaA8xTz/c/4PsLKNaUcLXJU73Ua/8wRRoYO9SNQz0XFEGI7oX
         lIgw==
X-Forwarded-Encrypted: i=1; AJvYcCX3c7jPqaXvsa87YWWK8e9RIS/yx9UyHrMz7M+rKZq5lekidqHaSMifw8qn705HBm3tOue1VJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd//IJCLh5YulAm5V2pqujSIKnoW/2XqvMaT8uM4izBgMWe29C
	kSEl11+SsQkMGmJKU0xsCfZCoImEWlvDalKQukJGRhRA41CAPCZe5Il+51F7QRbMXT7N6ZH628s
	amSvMfPqwf8+UKS7tS4TgTbE7yrg3u3c7jKvXvrrH4yeXa85QsEFdVnTEcg==
X-Gm-Gg: ATEYQzwpOcsiLHvMNeaaAjScREgudmf/7D62qF5MRKDTlNZgKmhn3w7bs6UTOjMNGa2
	5PjKT4xU4W+ttq6feMz+jB3/JH/T0mJzXdxAMyTPDe9Ai7Bobdoqy4bOVHHicdlfL/5rhQ5IeWi
	mliZEI7cumSC75pO9FWDjE6/tAfLCjDnVq2SfQEyMLXqJoZh0OXNacNLpOJlyqGbbL3pEXGyT/5
	+XBIi1INWxE0oTefJqxNRyodXJEAWb9Ew6B7Inh063w5Cr9zV8Ils7vRnH8sfwDobD1F4/CN0Bx
	c1+EqzOcfJBliAKRjzsiBAWcs/hGbvXVhgcjo1RpP0RoukR4JLa/Lsg81TIQnZg2zFFuJ0gtuYB
	yLuvvmf4QTPiE9wrbDbWt
X-Received: by 2002:a05:600c:4f52:b0:485:2fc5:3b0 with SMTP id 5b1f17b1804b1-486f4479614mr72745625e9.27.1773851628560;
        Wed, 18 Mar 2026 09:33:48 -0700 (PDT)
X-Received: by 2002:a05:600c:4f52:b0:485:2fc5:3b0 with SMTP id 5b1f17b1804b1-486f4479614mr72745025e9.27.1773851628051;
        Wed, 18 Mar 2026 09:33:48 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8b296b3sm2931335e9.6.2026.03.18.09.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 09:33:47 -0700 (PDT)
Date: Wed, 18 Mar 2026 17:33:46 +0100
From: Davide Caratti <dcaratti@redhat.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/3] tc-testing: add a test case for ETS
 offload
Message-ID: <abrT6s2LbrlriuJa@dcaratti.users.ipa.redhat.com>
References: <cover.1773759815.git.dcaratti@redhat.com>
 <7759f1fffdd0360e28687b660caaedba8ac6bed1.1773759815.git.dcaratti@redhat.com>
 <CA+NMeC-XtOcp_TrmKZ7DxLvdAXjsRciX3NLHhpuCCaGoNBpGtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+NMeC-XtOcp_TrmKZ7DxLvdAXjsRciX3NLHhpuCCaGoNBpGtg@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269113-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dcaratti@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.987];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fedoraproject.org:url,virtme-ng:email,dcaratti.users.ipa.redhat.com:mid]
X-Rspamd-Queue-Id: A08E22BF9DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 12:26:25PM -0300, Victor Nogueira wrote:
> On Tue, Mar 17, 2026 at 12:11 PM Davide Caratti <dcaratti@redhat.com> wrote:
> >
> > While reviewing the fix for unintentional u32 overflows in ets offload
> > code, Jamal said:
> >
> >  [...]
> >
> >  > otherwise a tdc test should cover it fine (when you get to the
> >  > netdevsim change perhaps)
> >
> > Add a test case to reproduce the division by zero fixed in [1].
> >
> > [1] https://lore.kernel.org/all/CAM0EoMm17wsYZmdFLshH3_-GrZtzd=i0xnoO2yiVB=-N4761mw@mail.gmail.com/
> >
> > Suggested-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Davide Caratti <dcaratti@redhat.com>

hello Victor, thanks for investigating!
 
> Sorry for not noticing this earlier.
> I tried some approaches with Jamal to avoid changing your patch,
> but changing it seems to be the cleanest way to do this.
> The issue is that tdc overwrites the environment when running
> the shell command from python so it can't find ethtool.
> We believe the cleanest approach here is to specify
> ethtool's path in tdc_config.py (as is done with tc and ip).
> Am sending a proposed change as an attached diff in this
> reply.

[...]

> diff --git a/tools/testing/selftests/tc-testing/tdc_config.py b/tools/testing/selftests/tc-testing/tdc_config.py
> index ccb0f06ef9e3..9488b03cbc2c 100644
> --- a/tools/testing/selftests/tc-testing/tdc_config.py
> +++ b/tools/testing/selftests/tc-testing/tdc_config.py
> @@ -17,6 +17,7 @@ NAMES = {
>            'DEV1': 'v0p1',
>            'DEV2': '',
>            'DUMMY': 'dummy1',
> +          'ETHTOOL': '/usr/sbin/ethtool',
>  	  'ETH': 'eth0',
>            'BATCH_FILE': './batch.txt',
>            'BATCH_DIR': 'tmp',

I see, and maybe now understand why I didn't see this problem before. My
fedora test setup does:

root@localhost:net# which ethtool 
/usr/bin/ethtool

and inside virtme-ng:

root@virtme-ng:net# which ethtool
/bin/ethtool

Moreover {,/usr}/sbin is a symlink because of [1], so it always finds
ethtool _ and would find ethtool also with the $ETHTOOL assignment
you did above; I'm ok for editing patch 3/3 adding the above hunks.

-- 
davide

[1] https://fedoraproject.org/wiki/Changes/Unify_bin_and_sbin


