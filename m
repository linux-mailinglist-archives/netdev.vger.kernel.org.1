Return-Path: <netdev+bounces-211853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52D7B1BE4E
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 03:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50C61739EB
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 01:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0B415278E;
	Wed,  6 Aug 2025 01:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="uZA77lKl"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B392A1114
	for <netdev@vger.kernel.org>; Wed,  6 Aug 2025 01:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754443770; cv=none; b=qfr3O1tdv/sRmpW9ALpGo/LCpbks0VJV1NfhuoZF5KbPNZSMYZAnACiVPqEPUJKnqP3UzdZ33j/K8a5WWsN3HCNNvzJxIr5shYBuAk0hlMr6ATQa5BdRp+IDdbtk8j20HrdmL13Z10rtR4P44NnA5+wbbq8Y/MuU+ubaZouneck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754443770; c=relaxed/simple;
	bh=vq5+wQ/sZKVUSxA6WKT8J8/f4W1wQcfvoDzdziAwqBg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HQL1J9+HTT9OahEkj/3sP3wBZCubqvYKucZNWsZ4dkTei1ewHMiwCnYE00R7nbmhfxBs8RRvHff1DDy5jZTZNhZZ+PRoBU5fKzaTe1EsRi769LO8caWTMyQRppAsRY7ARIAlufVJaAolZA6idxrbBXT98PekCnqNbGi9af+sZXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=uZA77lKl; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 5761T7sA005980
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 6 Aug 2025 02:29:10 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 5761T7sA005980
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1754443752; bh=vq5+wQ/sZKVUSxA6WKT8J8/f4W1wQcfvoDzdziAwqBg=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=uZA77lKlqXBkEnZV4a496adWWMV25XQU3ALGPqJXiz8Ptfr3eBEKTl5hob+MbNWBU
	 ijrTU0c3T0UPfdwXVJpHhByB2PWxpQBcK/wsll4q2H1WudaXaNSeWVAw3FmL6B6J3G
	 4Ijt+476O4sSs6hRt9XXe+IE5snJxjNCdZHymIsx/F+Fi7//pUrfj5w5kWk6vRbLgx
	 2XbVXquYvS3rEmuSS0FD//qu/0zBUK6fjS8bHSmW5usHCe5pM/5PdhcIakWAo4b2Pb
	 X4XbJ4SpEDN5OKiObfM13smf3LakhpXROlPQjh272B7QqzbxJMFw34eUdsuspI3PPn
	 lZVsTVx2OAg7g==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH net] net: dsa: validate source trunk against lags_len
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <42a1926a-6e1a-4b0e-92e1-2647d7c75993@lunn.ch>
Date: Wed, 6 Aug 2025 11:28:43 +1000
Cc: Vladimir Oltean <olteanv@gmail.com>,
        Ryan Wilkins <Ryan.Wilkins@telosalliance.com>, netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3C94A58A-68F9-49E4-B9D1-3D0C5FB62E3D@padl.com>
References: <DEC3889D-5C54-4648-B09F-44C7C69A1F91@padl.com>
 <20250731090753.tr3d37mg4wsumdli@skbuf>
 <42BC8652-49EC-4BB6-8077-DC77BCA2A884@padl.com>
 <20250731113751.7s7u4zjt6isjnlng@skbuf>
 <C867697B-7F5B-4500-8098-9C44630D7930@padl.com>
 <CAD3ieB36VnKAQPXUGbnRdWYFThf-VfLkhZTRfb9=ddndZEW3=A@mail.gmail.com>
 <20250805074226.agdnmeaip5wxzgkz@skbuf>
 <42a1926a-6e1a-4b0e-92e1-2647d7c75993@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> Luke has extended my patches to add pure RMU support. It does require
> the EEPROM has the needed contents to get the switch into RMU mode,
> but with that, no MDIO is required.

Or, a separate device connected via MDIO which places the device in RMU =
mode (optionally signalling readiness by setting a switch GPIO high).

More information was posted at [1].

[1] https://www.spinics.net/lists/netdev/msg1097599.html=

