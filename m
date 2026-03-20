Return-Path: <netdev+bounces-270060-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAvMKLWtvWnIAQMAu9opvQ
	(envelope-from <netdev+bounces-270060-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 21:27:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A39B2E0D04
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 21:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1078D300C265
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943442FE04E;
	Fri, 20 Mar 2026 20:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NaVDRB/0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5538F31280C
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 20:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774038450; cv=pass; b=Q6ktnhgS1cueqQREtZVxR0bV7G9beoMFnH1ye8sd5Y2Dyjy5RxXUTCOWS3/NRiroHtXAncr2/IbmaKlzWlDsKLgyNv/fPL50Bq5N6cypO26mP5phqFFvBv4mR1WBzTYSJPVsFWNbcDQuduPOJS9F4AsLx1OBucYasei+lzqy7oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774038450; c=relaxed/simple;
	bh=FU5uP3ZkjFJMWCBplg+yrqn6ovyOaZ7+c09IN0H1c6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HIC73DpOSzpICJcAkCFCrNgGQLgFWQqFWBOrdCEOq29UHAwBFCWmgZRpbQHxQmMQmygTr/GpIxDceQVWh3gFuf2dTpi475TN2Hlrg1aFeZgx6sT3Fif7wfcfmND/iyaN9GIC4WaGLdDEzKrGxckwvgUzWRbvfwQEq2hrdZRGOiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NaVDRB/0; arc=pass smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-35a1f549e7eso622648a91.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 13:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774038448; x=1774643248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOt8niiSMBDQXgzqGJjqff9RFRifAa9wYDYnxklNiho=;
        b=R/mBiGWhYrA707spiI3pAb80q60Tks5fhKzy4tbRb7XMAIzwAJk3uZfZKLV5jiRDdl
         Iwvd54gujs1Rt4GeiOw8jCTGljCBDS/FnhBMQeuQ9SuRsGhaHjXGtkHc+RnV1eRzbuBk
         NCGhazT6cK4XISi4tobIMzTaYqfu57VGZWJnrquGLIjU+/8a3/xvSs+cxdCZXbcHxNnW
         1HIUfRZhGQhqdjU3wQh1egTszLHMuVwcnFGbXpJcTBFCmk1di1/TOsAGS841BOsM66jw
         63Ktq7xzauyFs3Y7/aDw89ckwk2VLYLL3AAfzsdaog/U2fSI9NC+GqV/VlBexlUYGNMN
         cRzA==
X-Forwarded-Encrypted: i=2; AJvYcCWzAMLvuofP7AURBrzcMFi6u1MaPha5xF6C51hMSHIdKdtg/3nriN0O/phgQOzH96sx6pqgGDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYquayDTLrZLk6AOIXsWcLYERM+MNSp40DTwznnH5IpKslcf08
	43wGg48Q8jx69jPeWAgmxMRX2tykfG2FUmmjr/3VTTkLW29jRWrVaQMgCx4mLPViyB+O0kJujEY
	PsQ+B9oeu+8WFezLSE5ioLbyoyWTJpE4x19suOO8aGGtaKkq/hST6U5vO77kW4CGqjZmBj5SY+l
	FohANxPxurlG9IvHnTaVWd5xVqLpYI2l3k4xD24kQJleCun35xrVNJ05/9YRlR4oqRNj9ruZaQg
	jXRH3sDYfa2Fr2ggQ==
X-Gm-Gg: ATEYQzxR3u7ZLRK0bBVn38Ndst5vzH1OA6L53rfW3qXly2XIawn80lxTEzeMXhAUm2Q
	3Nhq+rAYqzyywTki0lHHfp/lnuZlrXg9gnuDGlv1T5AoU14V278s5bVusF5kTDJdVzVSU8MpYB/
	NdJZv0O8T/VcwR2fIhaGD+oSs1tRxLRmmAvSeWHC0EAgOhP00gMTfNpdzlzpnPooM2nu2bA4Vdp
	+RaIvdpPAEYDbxHDmZCd/sjI4Wy+DSv5Qh+U+c5qjhSQu9id42s4HVUylnuOv6654VwPd7GRt3s
	E6diMZvEqgtmJe3YPgZxzbJNaIa+/4Qngji/GscHWp3U26MHXqr3TLx88xvWtEkrYXiezBLHODv
	+4FgoJbsra9JX2HOvIeofp27Ecv0sOTxyMLRHFOdF62uvqhAdhRR+gPH7Pr5BFQoFciz9WviGYR
	o3EOE1WbDFCaOB/DN1kJNw3I5VN7ZRl4t44s7xBcT3YE0rA+4CMQlqEAKmxkRS38UJsQ==
X-Received: by 2002:a17:903:191:b0:2b0:60b2:4f8 with SMTP id d9443c01a7336-2b0827219a0mr42344465ad.15.1774038448469;
        Fri, 20 Mar 2026 13:27:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b08350b929sm4090675ad.18.2026.03.20.13.27.28
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2026 13:27:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2c0fb39b41aso17361534eec.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 13:27:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774038447; cv=none;
        d=google.com; s=arc-20240605;
        b=NjzDtafvxVM/duapBumos3MF445Aa1VfKFWZ3BPdHIB0gH4qOEnubbqkwN88vSv6db
         1yp7xzNClFH0721DirOZouB3FJB9Q4jUpZVC3+CHCzYss/LDu6k4MH0w8GfXM3T4rg3g
         1BdlgAT65CXkvzan0UFp42eQqDL7IYnuiWJRnK+fGDun5PZqUSFT6N/nzgm9SpHosdV/
         6SbF6+3oVmslrOHxs9y+w80dbLfhKsJZtGdW6FulGeB+XHUtJG+q4zukClxYW12XwGCh
         ejaITweWuCK75rV8OludFs5sv+3CDLLS3rjjZGCadsuR7TpMABdKpBDZwI8tG4JErqOB
         byog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xOt8niiSMBDQXgzqGJjqff9RFRifAa9wYDYnxklNiho=;
        fh=3Rf8moRASE51JPAL18c0RXesq7vZJ6FR/55zvQ+SV2o=;
        b=VWH1vYRCXXvWFX/0nIx2jCk8NBvTFDgo0iDUznY0z2TwXhqFco/uRR0aJFy/zP15zx
         6VVd3MOkFyiVNGy5M6z8IF2L+a1z8fCMylYYaMgxLGBQzT6/P6gTLiZZ974RSsUm3/8R
         JUt9RzUspY69pE6wNC1TIu2GeQ7O2+Npi3066bsY2Cf/a6Jf9aR48H1zrMkyRPjIldJK
         1x6T3tyHgkc1/amhrxP2Cn3H561qoFgHqAXAlGFeKzc6G8+VeerEXaBmFzUXahWWQSV3
         33c47Oy23bMxsRMP0ePPWeqMHVfVV3hHI0dvNQaGj2kqsf6bo23tCgv84ni9EZavAfLD
         BBXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774038447; x=1774643247; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xOt8niiSMBDQXgzqGJjqff9RFRifAa9wYDYnxklNiho=;
        b=NaVDRB/0RQPoxNpytfsRleA1XrMnQUTdpsfCkB9aVQyuViM8hUrwOmfQMDmaUfk/OS
         HCl+ysWLnXlwhlhxQkPCkqzQNUbxZvfeGUf9/c7WpOeF9TsX/IykQXI/hESrfuA6xCLK
         /oJOpw6oT2XsmQhtwy2QHCCQjYOkr4DyQbthA=
X-Forwarded-Encrypted: i=1; AJvYcCXrRPVsYvjSuGvlhRPli0lgTx+XJ7zpMUM1qQE9QrzLU2yFphKN1UzKrsF7Ug/M3VGuNCgNypw=@vger.kernel.org
X-Received: by 2002:a05:7300:8ca6:b0:2c1:778:d897 with SMTP id 5a478bee46e88-2c109752f8dmr2028415eec.21.1774038446682;
        Fri, 20 Mar 2026 13:27:26 -0700 (PDT)
X-Received: by 2002:a05:7300:8ca6:b0:2c1:778:d897 with SMTP id
 5a478bee46e88-2c109752f8dmr2028396eec.21.1774038446056; Fri, 20 Mar 2026
 13:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319055124.1350670-10-vikas.gupta@broadcom.com> <20260320112704.2065290-1-horms@kernel.org>
In-Reply-To: <20260320112704.2065290-1-horms@kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Sat, 21 Mar 2026 01:57:12 +0530
X-Gm-Features: AaiRm505TaUmdJLFecDrBSGjplEEA6grst5JytLaF5QdSEbee9ktgCMyb4hxd4w
Message-ID: <CANXQDtaMYzKS6KBR4mGmRgtQNvxX=ppBG8mgqZsxW=rQaKNFug@mail.gmail.com>
Subject: Re: [PATCH net-next v8 09/10] bng_en: implement netdev_stat_ops
To: Simon Horman <horms@kernel.org>
Cc: vikas.gupta@broadcom.com, andrew+netdev@lunn.ch, 
	linux-kernel@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	vsrama-krishna.nemani@broadcom.com, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, ajit.khaparde@broadcom.com, 
	rajashekar.hudumula@broadcom.com, davem@davemloft.net, edumazet@google.com, 
	netdev@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000075951e064d7a83c3"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270060-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2A39B2E0D04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000075951e064d7a83c3
Content-Type: text/plain; charset="UTF-8"

>
> Can this race with bnge_close_core when reading bn->net_stats_prev?
> bnge_close_core writes to bn->net_stats_prev while this function reads
> it without any locking.
>
> Looking at bnge_get_stats64, it uses rcu_read_lock() before accessing
> bn->net_stats_prev. While this won't cause a crash like the other two
> issues, it could result in torn reads on 32-bit systems where reading
> u64 is not atomic, potentially returning inconsistent statistics to
> userspace.
>
> Should bnge_get_base_stats also use rcu_read_lock() when reading
> bn->net_stats_prev?

Thanks, Simon.

Regarding the RCU suggestions: bnge_get_queue_stats_rx,
bnge_get_queue_stats_tx, and bnge_get_base_stats should not
require RCU protection here. Unlike ndo_get_stats64, these ops
are synchronized by the netdev instance lock. Since the writer path
(bnge_close_core via ndo_stop) also holds the netdev instance lock,
they are already mutually exclusive.

Do you agree, or am I missing a case where these ops can be called
without that lock?

Thanks,
Bhargava Marreddy


>
> > +
> > +     tx->packets = bn->net_stats_prev.tx_packets;

--00000000000075951e064d7a83c3
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
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCD7Uk9yH1gvNI3OWjZ7BNi8rVssZUz7HUu9VHCaIEMz7zAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAzMjAyMDI3MjdaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCczPLB
JBYEYa6XaolrdBZUbYeEk9ohmiQA3GraIyeoX8PzwBD/XsW5k5UzjbrLccMZ/RGPsv7mULt8XIWf
6VlX/nJqwnNGR9iRXL5G1FbX+/5UOdXnkEeVM3gFLo641IDDP3GeNZQkF1gawwFmi7tU7QPyae8F
Pu+4Hz7c6SPy0ZPvLuqtVirLSFrM9yDf5squuC4cDtp4dI5POgbM1iEEvIOidOtPqlXGtgIfGmHh
TxcVRHN57EmXmj9H4Lg8n6x43Rg39/rHMhxDAhSlaCqVKGgeNtrk5U4FHg8jidF9z9vJex2DWrhV
ZyQurm08TFoOhb+RHoZlKN2glhdONx7A
--00000000000075951e064d7a83c3--

