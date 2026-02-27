Return-Path: <netdev+bounces-261930-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AbXJdDWoWlcwgQAu9opvQ
	(envelope-from <netdev+bounces-261930-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 18:39:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4F21BB8B2
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 18:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C9B3304736E
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 17:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F003502AA;
	Fri, 27 Feb 2026 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ASufJbRd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4E94266B9
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772213965; cv=pass; b=ULGjDi2IQZRQ6khbGanSuIs1Q7Pd/Ty5pmTwxdW01TK0l5fY5b7eWb3QK2JJpNah+rcs+0nelNFOYM0SRw5cjf3pu5IA1SZ0DrYAcwX6Y3bpjy5cK6/78G+mnOLEXNK6hSjoyCov9kXXYlJ4VfrxLbUg0xUri1SnvwhYOwdne/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772213965; c=relaxed/simple;
	bh=waSLi2CA9rI9VokywQ2h9PhpTERx9nPqI8NubWWJq7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Su2JqnUYJdKmLGTtQFsu2wLWguU2XAFz6zDXl7nEaS6vi7pHvWJSQ0eehBhr2WPezsInHjDhHfuEtMCSXlB71F7csOVI1ALlJjC2lxFPpxQXZk0TCkEx08gwIXiOiMByIsOn0ZNbdbFgxOjE4BtLFVC+Jamn2xlbdAH8lH/6JjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ASufJbRd; arc=pass smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7d598f4c618so366601a34.0
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:39:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772213962; x=1772818762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDrSeh2xFceAP6OqRxTjdDdu2jd27Szyg8QU+BsWFAU=;
        b=pxkv1VReDpkdqWfm+dX3JrHZM4DEzX+i1unjJQ+zdZ0VC2YhnquvOJyOdcCGjXORz9
         mpfajRunLdGSp19JTIUp6WiB8UBlgcZ2MY908JIysH0Yvclldptf177WxxoGcJqzYMtt
         xCywSdLNLh/MlrASiYd454y72BaRYrV5vTbsvlFQ+sGVRTFf/BHsqsPtVmHy3b0RFgJ8
         1gKZzYgyOL4YiFPcc/TkNJRvuiGsbb3ZfiIl1t+ybfoE8l7HhZsJZppp65flxZrWKBsO
         b8vb8jq00WIcXA7AZMuHUAMVTJ3bsCB2Yj42VY5zBftAo4IL+0UQw7oU0wEgocRdEKLF
         VRfQ==
X-Forwarded-Encrypted: i=2; AJvYcCWQKC6TRCCTyRopgH4RzzGmpPiNDnz0TYubcmTUkJVorYauLI+i2ZbLNYeDp6bTbzHWMguVdKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiDz+iyuBRGgAp1glRvZQI5HgF84ePsZ8458JR4o4SMRoZMGfh
	cG8F/90YhE084bdC7MqVwsccub5ywFZcAxx4FSeTEuTannWloMXK3X90R0blItRvkqyH/NPtUzi
	3GjQnNq/sjOnCsmi9KNwN+bqMKXNc8505R8cbKZU9cp3O0ybjPTa4DhLYSXCK2sVtF5SqoChUYM
	W0+4b5jbUZuQpSzl3a0KC8QEZC7qou48T5MDc9wSq1SVnnmJxIJS+JZCD5P9U3gmnj4xy2fhVz9
	LKjcmmeiQPECvKZBg==
X-Gm-Gg: ATEYQzy058GYjkB8d+bVolbPpZBYfIu/haBKKW2SkPvGxCpEa+zQ/I72n285/g6Hu8k
	cFs28RDCkmwum4SlYXy3L4oylLSz3VWzZPO0FbqiKohSI/o2/1iyQ8ddwOoij8ctNcDaT8z/n8k
	5SyHn2anILhfpH725sOlzlzc1FyO/GG2C+rrVwPUY0o9jzIyGqnt1FTZoo8uDWKClP4KDiFgN1k
	WrYOnmDNdNIwP37hyCrPgDrvtl11c1rwMtzOtVNpr7/TCof6uVuNdA7CIv4h57EwUBL6CTx4bDg
	2rwvGd2NORoSJ0/FQVFQUsyXx6t9pK16BDmFpVFvUrlkhpAJuiELLdqy4sPcImMv4cUrkQ4do8i
	Yq1yO1Fbo43DzrrG+MFP3Bar1HJIb9G5q4hduTYK70qry1901TRMwf0e4e6xpp5P7/HPr2qg+JN
	o/y9wZl9taKEzBIjM4e+jpflOLV8XqGEwvYodUYZr0ziTbPYj2vRWNHIG60Xtgn+WwZw==
X-Received: by 2002:a05:6830:449e:b0:7cf:e4e6:2ce9 with SMTP id 46e09a7af769-7d591b3181bmr2511670a34.9.1772213962054;
        Fri, 27 Feb 2026 09:39:22 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7d5865024ffsm679936a34.4.2026.02.27.09.39.21
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Feb 2026 09:39:22 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2bded81809dso389045eec.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:39:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772213960; cv=none;
        d=google.com; s=arc-20240605;
        b=cSutrot8P/0rQ/EjbakCuzpacZ6YcCAblWCSNnKVH1vcQoM4PFDepQWYnUIE/1iLXE
         nm1nyHQv8jqHPwzOtZKAJLwM0e5ajoGo7fSJmu4TOaBTC/l5ryFleBaDUfnwK1V+409q
         0INePrcLUiFIOQO8pGeg7EaWve/OggtXWh9Xo2ukCYCuR1BMa9AQCh+ExRunnk3i0evn
         3p3MiTC6JcCCoYbaEX2JGOnCdJnrF/ibOAEuooUkRvJTV84cZpSEYtCIogU7Zkg7SjKt
         QTyiX7R0xuEoC0pRimtXFMnOHWgc/Zsfuay/KvEQsqo6wd+S0AJrvw8HLGFh8tHPhHij
         VOWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bDrSeh2xFceAP6OqRxTjdDdu2jd27Szyg8QU+BsWFAU=;
        fh=2HrHaQaz8gCmZ2/7E3IY3DbYSKHcO7FqQjcDScuve10=;
        b=jh5Duj7UiawFFUAMdfnsvra08u3sluZ3PEmg3aA4zWWyKEDyFQJ3iAExnqKdTf4M8m
         Mw3Uw8GMRiDrXlIYLbrX+kAupqQ6JNDOv0p1P0Yz4xBoxjDOnAeMuPZPa2PQxRUtUTZQ
         G/S++oJxuVgbmJLjXWg1RDUXpDVsSqJGufPruM/EcYH+sEh61jTc7YaRKVjDzaory8fV
         6oHp0kLNEqaeFI7nDdayHcmxZxmTssdL/hFMRYitWWKE2SJbYFGM+QOW0vE6dKKEwnaw
         rw2y9QS4sJN1kvoZaY/AaJ4BCHDZ4ce2mCQ5kplTjiH2jtdMPwVjmS8Gnn2HKScG3dke
         3PZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772213960; x=1772818760; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bDrSeh2xFceAP6OqRxTjdDdu2jd27Szyg8QU+BsWFAU=;
        b=ASufJbRdVENVKvMSEOVZW4p+YwbjHo03ZwRovltWvS5kLgZL/ONqK8TAMS4ndQ8kfb
         OZuuH0WNMllpSxwf2ifQ11o6UkcI2txU7iPo5Y7KT8evA0ZD4K/j0htwe46m+7hYYLQl
         D7Y+lP9riHotZpU7UKLw9ZVz1NO4Uy1LbuRVw=
X-Forwarded-Encrypted: i=1; AJvYcCWPkFUiKa3esXS4hFUoHo+I19Ox93d4K6QZzZWiVLah6WqFpw5NWtanQUYoGPOx3zNGzcOmsCw=@vger.kernel.org
X-Received: by 2002:a05:693c:290d:b0:2b8:26b8:3446 with SMTP id 5a478bee46e88-2bde1bb267emr1272190eec.2.1772213960291;
        Fri, 27 Feb 2026 09:39:20 -0800 (PST)
X-Received: by 2002:a05:693c:290d:b0:2b8:26b8:3446 with SMTP id
 5a478bee46e88-2bde1bb267emr1272179eec.2.1772213959808; Fri, 27 Feb 2026
 09:39:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226182133.1566714-1-bhargava.marreddy@broadcom.com>
 <20260226182133.1566714-3-bhargava.marreddy@broadcom.com> <c2fab025-310d-48c6-87fa-adc496541eac@lunn.ch>
In-Reply-To: <c2fab025-310d-48c6-87fa-adc496541eac@lunn.ch>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Fri, 27 Feb 2026 23:09:04 +0530
X-Gm-Features: AaiRm52d29XbsgaOKfrkGMvuTt2T8WTnPTvd9PgilLTgpcPu1erXUohtk9gTOWY
Message-ID: <CANXQDtaf9eaOrqUk33dg8pBm1MjmH14v88wAA9egCyM7j4u1Wg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/8] bng_en: query PHY capabilities and report
 link status
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>, 
	Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000097a217064bd1b71c"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261930-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,lunn.ch:email,broadcom.com:dkim]
X-Rspamd-Queue-Id: 0C4F21BB8B2
X-Rspamd-Action: no action

--00000000000097a217064bd1b71c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 2:34=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +int bnge_hwrm_set_pause(struct bnge_net *bn)
> > +{
> > +     struct hwrm_port_phy_cfg_input *req;
> > +     struct bnge_dev *bd =3D bn->bd;
> > +     int rc;
> > +
> > +     rc =3D bnge_hwrm_req_init(bd, req, HWRM_PORT_PHY_CFG);
> > +     if (rc)
> > +             return rc;
> > +
> > +     bnge_hwrm_set_pause_common(bn, req);
> > +
> > +     if ((bn->eth_link_info.autoneg & BNGE_AUTONEG_FLOW_CTRL) ||
> > +         bn->eth_link_info.force_link_chng)
> > +             bnge_hwrm_set_link_common(bn, req);
> > +
> > +     rc =3D bnge_hwrm_req_send(bd, req);
> > +     if (!rc && !(bn->eth_link_info.autoneg & BNGE_AUTONEG_FLOW_CTRL))=
 {
> > +             /* Since changing of pause setting doesn't trigger any li=
nk
> > +              * change event, the driver needs to update the current p=
ause
> > +              * result upon successful return of the phy_cfg command
> > +              */
>
> This commit is a little bit misleading.
>
> /* Since changing of pause setting, with pause auto negotiation off,
>    doesn't trigger any link change event, the driver needs to update
>    the current MAC pause upon successful return of the phy_cfg command
>    */
>
> The pause auto negotiation off is important here.
>
> The code is not the easiest to read because it mixes up PHY and MAC
> configuration.
>
> 1) If autoneg and autoneg pause is used, you only configure the PHY.
> When autoneg completes, you then configure the MAC with the results of
> the negotiation.
>
> 2) If autoneg is used, but not pause autoneg, you can optionally
> remove pause from being advertised by the PHY, but you need to
> immediately configure the MAC.
>
> 3) If autoneg is off, you you need to immediately configure the MAC.
>
>         Andrew

Thanks for the review, Andrew.

I will update the comment in the next spin and refactor bnge_hwrm_set_pause=
()
to improve readability and add more comments for better understanding.

Thanks,
Bhargava Marreddy

--00000000000097a217064bd1b71c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGqjCCBJKg
AwIBAgIMFJTEEB7G+bRSFHogMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTI1NVoXDTI3MDYyMTEzNTI1NVowge0xCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzERMA8GA1UEBBMITWFycmVkZHkxGDAWBgNVBCoTD0JoYXJnYXZhIENoZW5uYTEWMBQGA1UE
ChMNQlJPQURDT00gSU5DLjEnMCUGA1UEAwweYmhhcmdhdmEubWFycmVkZHlAYnJvYWRjb20uY29t
MS0wKwYJKoZIhvcNAQkBFh5iaGFyZ2F2YS5tYXJyZWRkeUBicm9hZGNvbS5jb20wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQCq1sbXItt9Z31lzjb1WqEEegmLi72l7kDsxOJCWBCSkART
C/LTHOEoELrltkLJnRJiEujzwxS1/cV0LQse38GKog0UmiG5Jsq4YbNxmC7s3BhuuZYSoyCQ7Jg+
BzqQDU+k9ESjiD/R/11eODWJOxHipYabn/b+qYM+7CTSlVAy7vlJ+z1E/LnygVYHkWFN+IJSuY26
OWgSyvM8/+TPOrECYbo+kLcjqZfLS9/8EDThXQgg9oCeQOD8pwExycHc9w6ohJLoK7mVWrDol6cl
vW0XPONZARkdcZ69nJIHt/aMhihlyTUEqD0R8yRHfBp9nQwoSs8z+8xZ+cczX/XvtCVJAgMBAAGj
ggHiMIIB3jAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADCBkwYIKwYBBQUHAQEEgYYwgYMw
RgYIKwYBBQUHMAKGOmh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZz
bWltZWNhMjAyMy5jcnQwOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dz
Z2NjcjZzbWltZWNhMjAyMzBlBgNVHSAEXjBcMAkGB2eBDAEFAwMwCwYJKwYBBAGgMgEoMEIGCisG
AQQBoDIKAwIwNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3Np
dG9yeS8wQQYDVR0fBDowODA2oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2
c21pbWVjYTIwMjMuY3JsMCkGA1UdEQQiMCCBHmJoYXJnYXZhLm1hcnJlZGR5QGJyb2FkY29tLmNv
bTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAd
BgNVHQ4EFgQUkiPQZ5IKnCUHj3xJyO85n4OdVl4wDQYJKoZIhvcNAQELBQADggIBALtu8uco00Hh
dGp+c7lMOYHnFquYd6CXMYL1sBTi51PmiOKDO2xgfVvR7XI/kkqK5Iut0PYzv7kvUJUpG7zmL+XW
ABC2V9jvp5rUPlGSfP9Ugwx7yoGYEO+x42LeSKypUNV0UbBO8p32C1C/OkqikHlrQGuy8oUMNvOl
rrSoYMXdlZEravXgTAGO1PLgwVHEpXKy+D523j8B7GfDKHG7M7FjuqqyuxiDvFSoo3iEjYVzKZO9
NkcawmbO73W8o/5QE6GiIIvXyc+YUfVSNmX5/XpZFqbJ/uFhmiMmBhsT7xJA+L0NHTR7m09xCfZd
+XauyU42jyqUrgRWA36o20SMf1IURZYWgH4V7gWF2f95BiJs0uV1ddjo5ND4pejlKGkCGBfXSAWP
Ye5wAfgaC3LLKUnpYc3o6q5rUrhp9JlPey7HcnY9yJzQsw++DgKprh9TM/9jwlek8Kw1SIIiaFry
iriecfkPEiR9HVip63lbWsOrBFyroVEsNmmWQYKaDM4DLIDItDZNDw0FgM1b6R/E2M0ME1Dibn8P
alTJmpepLqlS2uwywOFZMLeiiVfTYSHwV/Gikq70KjVLNF59BWZMtRvyD5EoPHQavcOQTr7I/5Gc
GboBOYvJvkYzugiHmztSchEvGtPA10eDOxR1voXJlPH95MB73ZQwqQNpRPq04ElwMYICVzCCAlMC
AQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMf
R2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMFJTEEB7G+bRSFHogMA0GCWCGSAFlAwQC
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCB6kchzobCIZR/gVheUAy605UwsQBxesao9af9XggwRJDAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAyMjcxNzM5MjBaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBv2Hut
x070F1437tNF4JmvFzmUGyt3lva7bemei3FL5FOVi6/nryLx4uJO/4xsDkXe6d/6t4FWGaznePP3
sHAYQopkwU26ir4jHTGflSxTXto2+Sh4lALp13jbnbwsZp/BvNs6extaJYjxOtl81GJhPZrGXrdq
g7LjYEfrO/vwAESfoAs1r2AC4UsnH7WddPa9+vjlt8NjDU3bhYVl6wakfvF/mUprKF94AyuWxbaE
mGw7xTkBH3q2BwhqR9G8tMbjhd3HCpz5ARDoSuhhcWY7+g12yp3nAVrR5taY9p0n+2oIrSovHYBv
P5PiEcp/wofB/LYfyIXyJ2FHdc5uIA9s
--00000000000097a217064bd1b71c--

