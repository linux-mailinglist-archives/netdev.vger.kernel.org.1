Return-Path: <netdev+bounces-243395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 501A5C9EF86
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 13:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA1B7348948
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 12:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910792DAFD8;
	Wed,  3 Dec 2025 12:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="eTTpbIXu"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4272DA777
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764764493; cv=none; b=iqHRsIi7KaLUJkDOhd5EThxmtM9m/ZFRzO3eN7CwRJnSz8saUpT/NNayd4kA9q9FUHo8AQOgPM8as51WyvfDYjh7bWVPvbpWczkt0/jkGBq2flkRSNE2cjbtaILtk3Gs1qrHLtkq/o5pr6nIP3mLq7W1QOaHUkUOv+GaclNdeh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764764493; c=relaxed/simple;
	bh=XoZqIOHHcb2KpxxqrYjy0PEUPFjNSsllZ5j9ZuKYEIY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ok7bJhuCnOg3NYCF3F4CXb9hoF8uFh55rwfC+8MXAwudtnx02ENygI7Xas8OQdakzaEyN21JaLv57pH/JkTj2HHM7MG8Ce2Wtz4h2yGmoSPpYpc7xIp5mADUBfAW1jSVjcOUttLHgP7n/6SidDiqg3FlSFDx1X+DvE2kxry4lGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=eTTpbIXu; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=eTTpbIXu;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 5B3CL4kU2496108
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 3 Dec 2025 12:21:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1764764464; bh=XoZqIOHHcb2KpxxqrYjy0PEUPFjNSsllZ5j9ZuKYEIY=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=eTTpbIXurW/ZiD2WsgFUvGMDwRLsgEUiWr1TBKDgkg2LkMN7fdO7WCNHFv1/gR4oN
	 MX8ME5/InzofFL9qD/hLbLpGwkxXtMObvC60vRu+rPVAJIhUq+p/xmH+nugmWuzkzD
	 DPaWOi8Fn87B02Fq6v4ozUfqykb8N3kG9DCiS1uI=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 5B3CL38v3574995
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 3 Dec 2025 13:21:04 +0100
Received: (nullmailer pid 1749026 invoked by uid 1000);
	Wed, 03 Dec 2025 12:21:03 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, "Lucien.Jheng" <lucienzx159@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [RFC] net: phy: air_en8811h: add Airoha AN8811HB support
In-Reply-To: <497ad08d-2603-4159-a4ce-52bdc5361aed@lunn.ch> (Andrew Lunn's
	message of "Tue, 2 Dec 2025 17:12:43 +0100")
Organization: m
References: <20251202102222.1681522-1-bjorn@mork.no>
	<497ad08d-2603-4159-a4ce-52bdc5361aed@lunn.ch>
Date: Wed, 03 Dec 2025 13:21:03 +0100
Message-ID: <878qfjn4cw.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at canardo.mork.no
X-Virus-Status: Clean

Andrew Lunn <andrew@lunn.ch> writes:

> Maybe look at having two different probe functions, with a helper for
> any common code? That might mean you don't need as many switch
> statements. And this is a common pattern when dealing with variants of
> hardware. You have a collection of helpers which are generic, and then
> version specific functions which make use of the helpers are
> appropriate.
>
> This patch is also quite large. See if you can break it
> up. Refactoring the existing code into helpers can be a patch of its
> own.

Thaks a lot for the valuable feedback! It all made a lot of sense to me.
Will be fixed in the next version if/when there is one.

But I'll let this rest for a while, to see if I can get the firmware and
testing issues resolved first.


Bj=C3=B8rn

