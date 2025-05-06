Return-Path: <netdev+bounces-188243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E42FAABC4F
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 10:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE9B506972
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA1623C4F2;
	Tue,  6 May 2025 07:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ug8zVkKs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F3223A9AD
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746517902; cv=none; b=poDD2itPqR71+0mZnmEpliCpczPDReBsdUcEfek1K+WQhPlSiHd5L+5wpZBkPRzyapLTxGVBP6zNEix+wHDqUC2UMOWQUBeyZZdnSGp6UNf3OuLqU9j9JXa9egHRBUsJB0uYDBrDl6qmDJGiVf7fVHDpcHuw7028z1mctMRJOgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746517902; c=relaxed/simple;
	bh=pl5OPutyKsg+Z1sBcUP+StmoSWV1JUI7XfC+CTyUjxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ai8+XRUeHXRpAkwa6ATxElyZq90kRbXg1VmO1hmTtqXsSwoJ5a1Ui3lr4gbaKfHYT5DlgNJyAkFs9EdyohqTL6cF8KTAWIp7pnxXorjUCOr2ZvPPlksJLZHFedMYBijfHHOP+pkie7UgN78k7/v8rCZALEtH94rOeNzhlwjIkQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ug8zVkKs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746517899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5HBVspWdQ+Fl1RGFmbNa4oPmFUDDRVe4VvohOGLQ5VY=;
	b=Ug8zVkKsXLnMafOEn0EFu0KGQLjLX2Iz+ZDCwjHvQ+uFTzJudVla0GPW5uQ2D1x+axJlbr
	ncso5wO2ZrOL+xbRcy1Wq/7/K52CYQPAHfySHUMJOEfD1GocQClz1Xk5lkFzMLs3vUmlX7
	+/puUI8TXmxjTxof9TD7tgJnmYf0TOk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-aaYDuHemOOWmhFrUqaaPlg-1; Tue, 06 May 2025 03:51:38 -0400
X-MC-Unique: aaYDuHemOOWmhFrUqaaPlg-1
X-Mimecast-MFC-AGG-ID: aaYDuHemOOWmhFrUqaaPlg_1746517897
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so29439685e9.1
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 00:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746517897; x=1747122697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5HBVspWdQ+Fl1RGFmbNa4oPmFUDDRVe4VvohOGLQ5VY=;
        b=wSe7MWrP0in+29ji4nTaCawvrfh1pW5AsEtZcPDrg9R3NlYwBWVj9dRlo/CwBXTtV5
         h7nMygmwB4TwhqcfIWTEH4sn3BtfaEov6PabjpPFwKTh7AYavgXCmDmjD6Mg5FN+/czD
         cREA5KC6JjKx3Z9o5kDO6/BcZRtdhhxy04vR5fb08aZRqIaY9h5CA7gt1wzA8LS51Fuw
         fOMdG0vgDscG4lwCBome53yLPVIL9pO3uAqMXR2F8xvfbtL9KGXBGilIswhEQhSWrJSq
         9MZ1PtB8QMkl8KwpL5st7/N30Ya6XQtQglY/O8mMDHkwltm8IToE5YcTrQV0kkDOK+Oy
         y9uw==
X-Forwarded-Encrypted: i=1; AJvYcCWmEcQEOtOinaDVCYhmARZM2fAPZ/0H/rO6RpatEPA/knBwjaOd4N/xM+eMDeRLx7KfnX90rNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw32Wf9Xzpbne04hDJghOAIoy3Slm+n2ZbdgHt7/DJBSmVdr7hZ
	/cCYKkuZuFuZOedzuqg0vS93E3+2KWRi2JuIRLdV4IXnXBc/29TItTmNxMuFFBVEeVaIQ14EygP
	IunCBLGT7ZaD0khtXLCglUJDDbtQ5dJxg1I7rhPYb2J+SpU2VBWCtLQ==
X-Gm-Gg: ASbGncu2HwfedhcmtDFqx+2pJs5u18gqNqjCJaYBYufy4lH+lNzC7mOWqZpMtAwIt9M
	GzZhEiIHNm7CPY+bXq7HrENracU+SKo+ZbwB7Iy4YTqVA0X0jZ8d96qImO0fibhmXrT10oE9pNj
	TUtbBmH41gzysv+SRuZaNpW/0S3REwO0Uw60q/Q48sW9ejnHPPivivkcxj86mwreu01SK+G+Eq1
	Y4ZyLbjoAXwhXyUPIkX9aaeE58faR/z3Phgf91wG0Kdo7yqjULOYZ/vWMxJO7wtOm4V66bjZUe6
	vj07FQX/fnFWYHSQylY5wPW84jPBHLBLhaOQzszLa8KDERE4Om+itVtX+E8=
X-Received: by 2002:a05:600c:1da6:b0:43d:209:21fd with SMTP id 5b1f17b1804b1-441d101530emr16668495e9.30.1746517897145;
        Tue, 06 May 2025 00:51:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4JCCBzyq6jjjPZ85Ct7gO4cXiSXJScVK2314x0EXxLsegTrsV4ue0Tzlfjo9FY9dHlO703g==
X-Received: by 2002:a05:600c:1da6:b0:43d:209:21fd with SMTP id 5b1f17b1804b1-441d101530emr16668135e9.30.1746517896823;
        Tue, 06 May 2025 00:51:36 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2706:e010:b099:aac6:4e70:6198? ([2a0d:3344:2706:e010:b099:aac6:4e70:6198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b28045sm202937545e9.35.2025.05.06.00.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 00:51:36 -0700 (PDT)
Message-ID: <89c05b7f-cc3b-4274-a983-0cd867239ae1@redhat.com>
Date: Tue, 6 May 2025 09:51:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 09/11] net: dsa: b53: fix toggling vlan_filtering
To: Jonas Gorski <jonas.gorski@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Kurt Kanzenbach <kurt@linutronix.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250429201710.330937-1-jonas.gorski@gmail.com>
 <20250429201710.330937-10-jonas.gorski@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250429201710.330937-10-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/25 10:17 PM, Jonas Gorski wrote:
> @@ -789,26 +805,39 @@ int b53_configure_vlan(struct dsa_switch *ds)
>  	 * entry. Do this only when the tagging protocol is not
>  	 * DSA_TAG_PROTO_NONE
>  	 */
> +	v = &dev->vlans[def_vid];
>  	b53_for_each_port(dev, i) {
> -		v = &dev->vlans[def_vid];
> -		v->members |= BIT(i);
> +		if (!b53_vlan_port_may_join_untagged(ds, i))
> +			continue;
> +
> +		vl.members |= BIT(i);
>  		if (!b53_vlan_port_needs_forced_tagged(ds, i))
> -			v->untag = v->members;
> -		b53_write16(dev, B53_VLAN_PAGE,
> -			    B53_VLAN_PORT_DEF_TAG(i), def_vid);
> +			vl.untag = vl.members;
> +		b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(i),
> +			    def_vid);
>  	}
> +	b53_set_vlan_entry(dev, def_vid, &vl);
>  
> -	/* Upon initial call we have not set-up any VLANs, but upon
> -	 * system resume, we need to restore all VLAN entries.
> -	 */
> -	for (vid = def_vid; vid < dev->num_vlans; vid++) {
> -		v = &dev->vlans[vid];
> +	if (dev->vlan_filtering) {
> +		/* Upon initial call we have not set-up any VLANs, but upon
> +		 * system resume, we need to restore all VLAN entries.
> +		 */
> +		for (vid = def_vid + 1; vid < dev->num_vlans; vid++) {
> +			v = &dev->vlans[vid];
>  
> -		if (!v->members)
> -			continue;
> +			if (!v->members)
> +				continue;
> +
> +			b53_set_vlan_entry(dev, vid, v);
> +			b53_fast_age_vlan(dev, vid);
> +		}
>  
> -		b53_set_vlan_entry(dev, vid, v);
> -		b53_fast_age_vlan(dev, vid);
> +		b53_for_each_port(dev, i) {
> +			if (!dsa_is_cpu_port(ds, i))
> +				b53_write16(dev, B53_VLAN_PAGE,
> +					    B53_VLAN_PORT_DEF_TAG(i),
> +					    dev->ports[i].pvid);

Just if you have to repost for other reasons:
			if (dsa_is_cpu_port(ds, i))
				continue;

			b53_write16(dev, B53_VLAN_PAGE, //...

should probably be more readable.

BTW, @Florian: any deadline for testing feedback on this?

Thanks,

Paolo


