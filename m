Return-Path: <netdev+bounces-306216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5CBGJrqXT2q7kQIAu9opvQ
	(envelope-from <netdev+bounces-306216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 14:44:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 371DF73123E
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 14:44:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OOpesoQk;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306216-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306216-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB4463013841
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 12:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EADA8472;
	Thu,  9 Jul 2026 12:42:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7374229C9
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 12:42:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600979; cv=pass; b=VZm4+SaIHfyPV9jNxJ6QgOSLT/JfJpKviuAgOHDJBtw9S8EbjoZ8wIxQRM8oMBJI3puat/p88Dt0n5HA9n3h6VTyZCEBY/ELNqsqgBK45AE0dh0uDq9E2YMJ0MCwv3Iw1c0N9sQy5px490IDPVgZ7PF+YaRLDHbzMTvZBBl2Rlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600979; c=relaxed/simple;
	bh=lGxuTmJonByeoKZLNGDqsTWGMGeNSB8gf+bZY9/34MI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KlNtumz/V5FPIvW7b8nQMsgVD/Hu4ylIzH3WriX7T+9231M0s1ioV1Q3Iz9h0izalaiJiVupeDornszi7bvltb/dKVBAi9e/cs2LpXeJhIO3qP0K7hMWAXCVgkkHy/HBLQKC+XeJg4pmiyvL+cnuIH2DcQ/kc3Lhhteb7bIcVn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOpesoQk; arc=pass smtp.client-ip=209.85.218.45
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15c257a488so240129366b.3
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 05:42:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783600974; cv=none;
        d=google.com; s=arc-20260327;
        b=k/E0+SJ/J6kGGmMfemEsse1ejQ3hK49v8GzPLYhz1J/VPeq8d2oH/EwwCJPE1X1Yjl
         IcTVnWOGnmGO/4EawD6Pm6zSgJAwBVJ2c9LNrzZy83/6p374QWa04W1NAf5nHXdlsivr
         /beNJYqUhsgIwpy1Gn03E6l6hcYx2D8Z8TvU/fy8xFUtRUPyairhG5VMSjPNyOkJL0yE
         3RiZeh3ojCILRq9FjgrNW+OSG7W9YXZrazUOf4ovnEFYpPqB7SIfaIaRLTiTkxNQGHEX
         KlS/1/M2tzsRJK1X1w+Luj3Dt04YEF+YNCuvkEYeZMN9i0AUzeJp0r2OWCy8E8cDCG4P
         hK4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lGxuTmJonByeoKZLNGDqsTWGMGeNSB8gf+bZY9/34MI=;
        fh=1d2FB8uMgcXbYEDw2h+JK3oWsDkNiF8G6JXKvR7Vy1A=;
        b=Hv8/1XDelTt/bi+MozPDxD2Rejze7U2VntkJr4OK8E/jF8v8eXMJnF7wN0sx3ON27E
         zC/TsZedwoFuJ6qYOUsdW/S7Bryntihr6xDqm9sKvI8IBZCpvS3JXbZ70SBRhbGpq/kl
         1UUqnbhma5dmEi7Ya7PU9kEKwBccPmJO1z4aERR+bbEFhNvHVSSiqgXss45Or5Rm/yQO
         +oIHHNdskQzDCQ8afq276crQxbAVPdPyHPZr6plKiloBtRHtHD3tVcAIJk7Hpc3iERKw
         /bCFgDr/TSdsfSCA2cfGiWRuNnqJZxA7YZWdF3ckGIkx64GdmvybX9aUaBjhlj+Y4b+P
         +JTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783600974; x=1784205774; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lGxuTmJonByeoKZLNGDqsTWGMGeNSB8gf+bZY9/34MI=;
        b=OOpesoQkL9ODcjf8lsUxf2MPbMrsTNKyPDubu/sUok1vmvHEX5ssLfKeZRgtG/9h+E
         V6At1tPK6vV9ampmZy38/HwsMCAOVec/B+rrVruZLguWfnBAnYEdeFdYlUtQPFvuOxc1
         jAXhP6jUrfG7GBWnNElrOgEFA00mQGTNzZRKhia/FnNle6ndvgFeel9NAmMsaY+9JmTQ
         Iq8CRPA3inpi/2Axou/c4/m6UaRU5Ed4xpztgNH7iuy6kgixq9jbQ9iHIiy45bJUzf5F
         NF6e+mH8Yg57lwJjLSqCYPIdqVYzbU7O1Lvl0iFBmh5ne/J6MoBuqmAYsqrh+ZwSsxmn
         RDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783600974; x=1784205774;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lGxuTmJonByeoKZLNGDqsTWGMGeNSB8gf+bZY9/34MI=;
        b=AOj6sRDPTQtUtqQgBPBJODtxqbQXapZAfm38wQUCuDi4clCqtPoLLaJStlVlAMyiwN
         amc9G5KFwjO70pQybgqdgCjtLhuAJRXem7LPbWUXiARdUJ2+iIr8Jc9iA53VLxgNojuT
         tTt9isbCbX096tKol91Ntx/qR+++yF8fqKCXkSssgeGXH+6+pxSWOhQ3tODq56rTdr/G
         wmTgjQ5dKBAG51dzTPUfWS3LBDKCzDIDcAwnyFZs92zHFTJdqAIK5ooQUatLSSdLzFu6
         0NNhoFLNMsM4YTrTA3MNM/KqH4UwG0RkUVjZjovlxKfEG6c0l7k1oJR2cKswAzB+s+t5
         X91A==
X-Forwarded-Encrypted: i=1; AHgh+RrLGtodzWfxmCod1VZcOKeo98d8I+PF4JCn5wlaUOJAzpYZbsm0tEtw7KZz/HHFwYLbduLgOOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQek3tHO8lznx9iQqL88aVN7GkBAbNByiBsauy/J+t8MgKfBRf
	A2c2P4EtHre+Hk2ZTAb2Jn2FEsqNfwurgvtDjvk6hcFKq9/yG2ael12IskTlQKJnKAjmRwuqd95
	gVVl7Uit3ceanH2TWeH/w5cfquDVrQio=
X-Gm-Gg: AfdE7clv/YD73t8rUTKWs2IeoiGuhT9q6sVtohFW5jXJ79E5XwZ4Ruql7Auh9VbZIHR
	zCsR2auJqV8sOXKIzKZVf/N8YjhondE31ka8+Gnt/5rH1mH423zxAB+Ug7aBiVySBH6Kr0V19Qq
	HUniXHfWIRkWDci61loROzlgKxIxKmiUj3+NADzTQT2xPHXaP105hPf+I7aZBAOjKAyEIlo+SND
	AGqVTFlBx3Mndp+mA0CqAuEj+Dd/G3psA+jG1piva853P6XSGFdpGgIOZrBKd8LvEo3azeUvC8O
	2ntG6A==
X-Received: by 2002:a17:907:782:b0:c15:b368:28ba with SMTP id
 a640c23a62f3a-c15ce1dc0f9mr300135666b.56.1783600973674; Thu, 09 Jul 2026
 05:42:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709101327.9508-1-royujjal@gmail.com> <2026070925-delay-gauntlet-bc7c@gregkh>
In-Reply-To: <2026070925-delay-gauntlet-bc7c@gregkh>
From: Ujjal Roy <royujjal@gmail.com>
Date: Thu, 9 Jul 2026 18:12:40 +0530
X-Gm-Features: AVVi8Cf_qxhMx1ZeQ3oKQ5Ke958RTxWs-_NyJm9hkmAWt83JY7oFCTeQuoLyaug
Message-ID: <CAE2MWk=mm8_bkd54Gv1mdox6rfvx85Dd3AjOCxPz0fPAfyuWYA@mail.gmail.com>
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to 6.1.y/6.6.y/6.12.y/6.18.y/7.0.y
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linux Stable <stable@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>, 
	bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:shuah@kernel.org,m:aroulin@nvidia.com,m:yongwang@nvidia.com,m:petrm@nvidia.com,m:ujjal@alumnux.com,m:bridge@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306216-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,linuxfoundation.org:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 371DF73123E

On Thu, Jul 9, 2026 at 4:34=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Thu, Jul 09, 2026 at 10:13:27AM +0000, Ujjal Roy wrote:
> > Hi Greg,
> >
> > Please consider backporting the following bridge multicast fix series t=
o 6.1.y, 6.6.y, 6.12.y, 6.18.y and 7.0.y.
> >
> > 726fa7da2d8c ("ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify ca=
lculation")
> > 12cfb4ecc471 ("ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()")
> > 95bfd196f0dc ("ipv4: igmp: encode multicast exponential fields")
> > e51560f4220a ("ipv6: mld: encode multicast exponential fields")
> > 529dbe762de0 ("selftests: net: bridge: add MRC and QQIC field encoding =
tests")
>
> Why is any of this needed in older kernels?
>
> And 7.0.y is long end-of-life.
>
> And why, if this does fix issues, was it not tagged for stable to start
> with?
>
> thanks,
>
> greg k-h

I already explained this in the email thread, "Please backport bridge
multicast exponential field encoding fix series to stable kernels".

