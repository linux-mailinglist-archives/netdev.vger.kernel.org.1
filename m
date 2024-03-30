Return-Path: <netdev+bounces-83608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC1A893307
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 18:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7713283D9C
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 16:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61749145B12;
	Sun, 31 Mar 2024 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PBZbgQcq"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDA3145321
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902455; cv=fail; b=FVFQbUyXX+hRGOqUQPRswc8bCWcONr3bXEzeOTQe/JWZoHHcKXopshtdjeU8YobR9mHhOzn/p3rgPQwHOQ74A5Qwe8pYl1slg3Rh2FDZxdi3oz7iPAnNP6ySV+YsV1ZCRcUcBEMYT8yZccZp6qpAU8MIkk/yopU56+dCyDAvi9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902455; c=relaxed/simple;
	bh=3yYBZb3UF5EVrq/E/KcmgW6Ykc6GcgvIvBoWJW8Addc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+mM+0JGYTb6yadsT4ZPcStUmbjtu7dofZis777HhtPrM5Ks4Vg5VXi6iY9Imw2JWN/h7c620dCi3ExVhGOGgQZj+RWTYa05cPKQWh5/BebQAXRp5/HUZ2HUekIf0PSXyNNDFVFTqPe6X6me+z0cJeSZqgoEcCUs6xFndVsWmtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lunn.ch; spf=fail smtp.mailfrom=lunn.ch; dkim=fail (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PBZbgQcq reason="signature verification failed"; arc=none smtp.client-ip=156.67.10.101; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=lunn.ch
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 64B8620851;
	Sun, 31 Mar 2024 18:27:31 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LlD2vXaxus5z; Sun, 31 Mar 2024 18:27:30 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id EC829208B5;
	Sun, 31 Mar 2024 18:27:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com EC829208B5
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id DEB68800056;
	Sun, 31 Mar 2024 18:27:29 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:27:29 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:55 +0000
X-sender: <netdev+bounces-83534-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAUaRAQuxQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgCNAAAAo4oAAAUABAAUIAEAAAAaAAAAcGV0ZXIuc2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 11659
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.199.223; helo=ny.mirrors.kernel.org; envelope-from=netdev+bounces-83534-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 4D9CC20820
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711835831; cv=none; b=o3bmGg6pkxuKNLm23H/EqQl645mc3BI/3oNOnCmXXZeDTufy4S/7XoTQckaCTsQgQPfJ1oCkaO6nIW3MXaFEVFyHktLJfRbH2yk609gThZggBQh+G6ND84LMgOQYRvJsHTSzLdM/7WchqsReFhlSICSnm9tENjPKVSVZFcZUWmI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711835831; c=relaxed/simple;
	bh=p8JMrR3aXxDyceVxKGrjVePzewVWjN37i/MfiACxrRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccWt3HBLvS2OtGm3Ycn21Leg/8+JZXm2Z9Ar33psizw6Ywv3BgORO6Ckh90tqq6sWTFhv2V/gQpr631zW6reHM8kdXGh044T2C270gIj2TzxdFBYQ+TjGsrSta6WOIIbwiRgt+z9HVlYHX4ep4OLtsd+CphA2ThRAj3Ga1w3Cdc=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PBZbgQcq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IZ0VCe3iNf6wEVXOTCw6lmBDLZ7NjriGD/YDnR3wMN4=; b=PBZbgQcqz+Z/9+/z5NNgXvLHao
	y+Z95swHz8k9SInML7Cx6typz+jPac5PQ8x2QOVjZiHrhxDhb6tkgljD806DlPmYqcV54edGZmbCl
	y8BmaRaIJM2yB2pDVuq/vtwhzgL16ybpZWuM+0dzv0/X9Nml7k+SAMK9FfVrBl/aRKLQ=;
Date: Sat, 30 Mar 2024 22:57:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	simon.horman@corigine.com, anthony.l.nguyen@intel.com,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	idosch@nvidia.com, przemyslaw.kitszel@intel.com,
	marcin.szycik@linux.intel.com
Subject: Re: [PATCH net-next 0/3] ethtool: Max power support
Message-ID: <38d874e3-f25b-4af2-8c1c-946ab74c1925@lunn.ch>
References: <20240329092321.16843-1-wojciech.drewek@intel.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329092321.16843-1-wojciech.drewek@intel.com>
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Mar 29, 2024 at 10:23:18AM +0100, Wojciech Drewek wrote:
> Some ethernet modules use nonstandard power levels [1]. Extend ethtool
> module implementation to support new attributes that will allow user
> to change maximum power. Rename structures and functions to be more
> generic. Introduce an example of the new API in ice driver.
>=20
> Ethtool examples:
> $ ethtool --show-module enp1s0f0np0
> Module parameters for enp1s0f0np0:
> power-min-allowed: 1000 mW
> power-max-allowed: 3000 mW
> power-max-set: 1500 mW
>=20
> $ ethtool --set-module enp1s0f0np0 power-max-set 4000

We have had a device tree property for a long time:

  maximum-power-milliwatt:
    minimum: 1000
    default: 1000
    description:
      Maximum module power consumption Specifies the maximum power consumpt=
ion
      allowable by a module in the slot, in milli-Watts. Presently, modules=
 can
      be up to 1W, 1.5W or 2W.

Could you flip the name around to be consistent with DT?

> minimum-power-allowed: 1000 mW
> maximum-power-allowed: 3000 mW
> maximum-power-set: 1500 mW

Also, what does minimum-power-allowed actually tell us? Do you imagine
it will ever be below 1W because of bad board design? Do you have a
bad board design which does not allow 1W?

Also, this is about the board, the SFP cage, not the actual SFP
module?  Maybe the word cage needs to be in these names?

Do we want to be able to enumerate what the module itself supports?
If so, we need to include module in the name, to identify the numbers
are about the module, not the cage.

    Andrew

X-sender: <netdev+bounces-83534-steffen.klassert=3Dsecunet.com@vger.kernel.=
org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQAVABYAAgAAAAUAFAARAPDFCS25B=
AlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURh=
dGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQB=
HAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3=
VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4Y=
wUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5n=
ZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl=
2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ0=
49Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAH=
QAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5z=
cG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAw=
AAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbi=
xPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQ=
XV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1p=
Y3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmV=
yc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAUaRAQuxQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgCOAAAAo4oAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQA=
CAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 11670
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 22:57:27 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37 via Fronte=
nd
 Transport; Sat, 30 Mar 2024 22:57:27 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 903C720883
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 22:57:27 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.751
X-Spam-Level:
X-Spam-Status: No, score=3D-2.751 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIM_SIGNED=3D0.1, DKIM_VALID=3D-0.1,
	DKIM_VALID_AU=3D-0.1, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_NONE=3D-0.0001,
	SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001]
	autolearn=3Dunavailable autolearn_force=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (1024-bit key) header.d=3Dlunn.ch
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dzDR-mKVAYro for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 22:57:23 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.48.161; helo=3Dsy.mirrors.kernel.org; envelope-from=3Dnetdev+boun=
ces-83534-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=3Dsteffe=
n.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com B65A020820
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id B65A020820
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 22:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 263B5B21BA2
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 21:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FD04AEF3;
	Sat, 30 Mar 2024 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (1024-bit key) header.d=3Dlunn.ch header.i=3D@lunn.ch header.b=
=3D"PBZbgQcq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9788217D2
	for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D156.67.10.101
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711835831; cv=3Dnone; b=3Do3bmGg6pkxuKNLm23H/EqQl645mc3BI/3oNOnCmXXZe=
DTufy4S/7XoTQckaCTsQgQPfJ1oCkaO6nIW3MXaFEVFyHktLJfRbH2yk609gThZggBQh+G6ND84=
LMgOQYRvJsHTSzLdM/7WchqsReFhlSICSnm9tENjPKVSVZFcZUWmI=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711835831; c=3Drelaxed/simple;
	bh=3Dp8JMrR3aXxDyceVxKGrjVePzewVWjN37i/MfiACxrRY=3D;
	h=3DDate:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=3DccWt3HBLvS2OtGm3Ycn21Le=
g/8+JZXm2Z9Ar33psizw6Ywv3BgORO6Ckh90tqq6sWTFhv2V/gQpr631zW6reHM8kdXGh044T2C=
270gIj2TzxdFBYQ+TjGsrSta6WOIIbwiRgt+z9HVlYHX4ep4OLtsd+CphA2ThRAj3Ga1w3Cdc=
=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dlunn.ch; spf=3Dpass smtp.mailfrom=3Dlunn=
.ch; dkim=3Dpass (1024-bit key) header.d=3Dlunn.ch header.i=3D@lunn.ch head=
er.b=3DPBZbgQcq; arc=3Dnone smtp.client-ip=3D156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dlunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dlunn.ch
DKIM-Signature: v=3D1; a=3Drsa-sha256; q=3Ddns/txt; c=3Drelaxed/relaxed; d=
=3Dlunn.ch;
	s=3D20171124; h=3DIn-Reply-To:Content-Disposition:Content-Type:MIME-Versio=
n:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject=
:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3DIZ0VCe3iNf6wEVXOTCw6lmBDLZ7NjriGD/YDnR3wMN4=3D; b=3DPBZbgQcqz+Z/9+/z5=
NNgXvLHao
	y+Z95swHz8k9SInML7Cx6typz+jPac5PQ8x2QOVjZiHrhxDhb6tkgljD806DlPmYqcV54edGZm=
bCl
	y8BmaRaIJM2yB2pDVuq/vtwhzgL16ybpZWuM+0dzv0/X9Nml7k+SAMK9FfVrBl/aRKLQ=3D;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rqghD-00BkPE-0K; Sat, 30 Mar 2024 22:57:03 +0100
Date: Sat, 30 Mar 2024 22:57:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	simon.horman@corigine.com, anthony.l.nguyen@intel.com,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	idosch@nvidia.com, przemyslaw.kitszel@intel.com,
	marcin.szycik@linux.intel.com
Subject: Re: [PATCH net-next 0/3] ethtool: Max power support
Message-ID: <38d874e3-f25b-4af2-8c1c-946ab74c1925@lunn.ch>
References: <20240329092321.16843-1-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dus-ascii
Content-Disposition: inline
In-Reply-To: <20240329092321.16843-1-wojciech.drewek@intel.com>
Return-Path: netdev+bounces-83534-steffen.klassert=3Dsecunet.com@vger.kerne=
l.org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 21:57:27.6324
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: ba3aa9db-22e3-4c07-4c0e-08dc=
510463d4
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-dr=
esden-01.secunet.de:TOTAL-HUB=3D0.389|SMR=3D0.342(SMRDE=3D0.034|SMRC=3D0.30=
7(SMRCL=3D0.102|X-SMRCR=3D0.307))|CAT=3D0.046(CATOS=3D0.011
 (CATSM=3D0.011(CATSM-Malware
 Agent=3D0.011))|CATRESL=3D0.020(CATRESLP2R=3D0.017)|CATORES=3D0.013
 (CATRS=3D0.013(CATRS-Index Routing Agent=3D0.012)));2024-03-30T21:57:28.03=
4Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 8117
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-02.secunet.de:TO=
TAL-FE=3D0.012|SMR=3D0.011(SMRPI=3D0.008(SMRPI-FrontendProxyAgent=3D0.008))
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAa0EAAAPAAADH4sIAAAAAAAEAHVUTW8b=
NxDlWtqVtIrygb
 bodQ69VRIkJwFaH2IYTQLkYNRoCuhQ9EBpKYvpLilwuZb10/rv+obU
 ynLqAMSCO3zz8WYe+e+z3w19dHpM19LR+a9jOp+dvyHpaT67OH99Mf
 /l6pp+ns1nszEt7JeVVqsNvXdqp/6hnbNeXYzyd/TZVoqU3yhnlKfK
 Fk2pampqRcaa2ktTSFfQ1u6Uo1LdqbKmv+Z/T+nDvVemYE9vbcmRoi
 /paluqShkvvbaGvKW62W6t82TUDtV5p5eNRw6/Qak7XZYky9LuOKfj
 OPBYbaS5VVTJe101Vcw+pT+UkSi29q5Z+cYhBKqjdWNWnKlmxyWcrF
 Mc5lYZ5fRqSp+MdyhtpQAndS+5PrJr5FehpKubT6QNaQAKp++QCe4c
 4UPk1vrUoV8/tZRpMqk3djc50FZmO69n65nZzhh2Ha1b6VCyV66mtX
 WnoBAsEJtU2kxCC1RxgdnNZlQtTk7l/cPp66dOa+Xh97Y9+V+Vyj9R
 5GN/eoPAo3yULxRt5B1/CpJUqDtui3cKVJzdKuf3gYik0ppb8rpiFY
 1yamc1aSmVpd5h2Bd8hlNt+DTSi6ZCrWVT+semeuX0lqd58CNoO2rg
 wCAKcYVxN1UA0uetWum1DoL6SjKnuDZeaKVcItRyDxqtaE3wrkvrx/
 wT6p8sQKCe0g2kBj2X+/HxfqzkMSAk12xZe/PFmObTtwtCf84XU27L
 b7YpC9rbhtal3kbFsYSlsw2kGwXLReoat4lvg8cV/fOSfd+1TTu09C
 mFPG76Uyp5jHislFF+VdZ2TDu+iIUFrSczksRtw35PXuGyNvUlvbeB
 lK7krTa4bfpwkfE+OKa0VHyh5wtsVpLfEly3JRS1tPyYYMz61hyjBL
 3JUf41AHVpvFihMGP94ZWYLy4fKvcbXROWXNrGh/aGAOOw/fzxBnO6
 VePgzZZIhA9GeZzkJQtsj4r5eGeRmz3wLKiifU+iNOo4uTokR+E7wC
 UmFjFBT9gq01TKSa9iT4MgDwLztSrX7VPIYT7hj5sfs7G3NquyKdRX
 muS043BcQCJ6vY/WplriVRnl0qkT+tH1gTGzmcYLSnRlCrz+/CfEme
 h0RNpJxDMs0T0T3a5Iz5JOPxF9gdXHPhUiFb2+GGSil4ocAOx7ot8R
 3aF4loosSwAXiegC0BNDfJ+LF4gcMbkYwgULyC4Cik6A9RETG5wCMx
 A57FgA9MQg/vYCGKdxxX0mnsPeF6NEnPVQTCKGIkWcoXhxjDYUL9NE
 vBIZ9r1k0BWCSYnsW8ZRMHaStDUOYnC0JQ+kmOYDrBtg/VBtCgvAwM
 S2xN/Ad9hLxI9MMxuIl23G/LgZiu9BJLQ0Q3xQ5sICfii+ix2IkSPx
 rsiwSZlvhtYNEJ/bO4x945V0wxTOWgtHDo5p/MZQWHEioIkKfwgZTx
 vyLeOrYDzpEqaZxck+uPBoBuH0MC9MMzYqGKGl7HSyLJ52D0DyYOwF
 taTx94zbmx0jBGMvqqIbhxLG1GGOgyPrKLljf1Lu21Fm6elmEFQdg2
 Qs9djV7hEQJ3U6iDjrXvjGjFlQewCMsv8AWnKrhZUJAAABDs4BUmV0
 cmlldmVyT3BlcmF0b3IsMTAsMDtSZXRyaWV2ZXJPcGVyYXRvciwxMS
 wwO1Bvc3REb2NQYXJzZXJPcGVyYXRvciwxMCwwO1Bvc3REb2NQYXJz
 ZXJPcGVyYXRvciwxMSwwO1Bvc3RXb3JkQnJlYWtlckRpYWdub3N0aW
 NPcGVyYXRvciwxMCwwO1Bvc3RXb3JkQnJlYWtlckRpYWdub3N0aWNP
 cGVyYXRvciwxMSwwO1RyYW5zcG9ydFdyaXRlclByb2R1Y2VyLDIwLD c=3D
X-MS-Exchange-Forest-IndexAgent: 1 1418
X-MS-Exchange-Forest-EmailMessageHash: ECED4171
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

On Fri, Mar 29, 2024 at 10:23:18AM +0100, Wojciech Drewek wrote:
> Some ethernet modules use nonstandard power levels [1]. Extend ethtool
> module implementation to support new attributes that will allow user
> to change maximum power. Rename structures and functions to be more
> generic. Introduce an example of the new API in ice driver.
>=20
> Ethtool examples:
> $ ethtool --show-module enp1s0f0np0
> Module parameters for enp1s0f0np0:
> power-min-allowed: 1000 mW
> power-max-allowed: 3000 mW
> power-max-set: 1500 mW
>=20
> $ ethtool --set-module enp1s0f0np0 power-max-set 4000

We have had a device tree property for a long time:

  maximum-power-milliwatt:
    minimum: 1000
    default: 1000
    description:
      Maximum module power consumption Specifies the maximum power consumpt=
ion
      allowable by a module in the slot, in milli-Watts. Presently, modules=
 can
      be up to 1W, 1.5W or 2W.

Could you flip the name around to be consistent with DT?

> minimum-power-allowed: 1000 mW
> maximum-power-allowed: 3000 mW
> maximum-power-set: 1500 mW

Also, what does minimum-power-allowed actually tell us? Do you imagine
it will ever be below 1W because of bad board design? Do you have a
bad board design which does not allow 1W?

Also, this is about the board, the SFP cage, not the actual SFP
module?  Maybe the word cage needs to be in these names?

Do we want to be able to enumerate what the module itself supports?
If so, we need to include module in the name, to identify the numbers
are about the module, not the cage.

    Andrew


