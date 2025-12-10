Return-Path: <netdev+bounces-244210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E7FCB2791
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 09:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED6B73050B99
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 08:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009F826E6FA;
	Wed, 10 Dec 2025 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bfgzi6ht"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBEA1CAA79;
	Wed, 10 Dec 2025 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765357067; cv=none; b=VWp+45QBUYg86Q05CaTrHs28LQ6AOFuzMDWNJDMqay+myNGTAuUd3PaK1VyE47SPJaPZVr/VD7MF1muzvjooaS1xOhL270AP0ThMUvP6+MdOkgRWeRW9iIIcRMUewwjmV1AJYTqpWqh4BCg/LYbNCkHFSAqAHq7cfYga7aWC8jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765357067; c=relaxed/simple;
	bh=EPclZucFX7AUieJWyQ6LgdWVf0kbFbb2uxZpv0dy4TY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j1xl2A2WxQUEVNgdupmMyOM0plR4RtzEB7nSJq2BiBx8vX4TTB4ruk3B8qok7Opb7qbCGIba6IvQPoJwAYvqg7yNExYjs2q+Sts9yLTuz3wWqacSWBEElHdCKWHZFif/arZ6BWDdDT2evi7MWpjPR5KFpkwPML61Hrl5FARvuD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bfgzi6ht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506CAC4CEF1;
	Wed, 10 Dec 2025 08:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765357067;
	bh=EPclZucFX7AUieJWyQ6LgdWVf0kbFbb2uxZpv0dy4TY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bfgzi6ht2JuYoBOGXiDEinQTBcO5jOc/RNqvRF9KgLeSPrRF5jyzIJxqQgusZA0g1
	 IxrhuV0ix/sAoCpRl001j0zAJI1KNsNSJHm07Et+cWyxzCPElUKF/ByfV8f1n0HBsk
	 /9B2RHGg7gJBtYFJgTw0oWlhaTc8FhfQsn016gwvAsJjndnx5Sfwu+Sf3cED+U6fK9
	 cgUGiXgsNGouy0Qe2AVOT51u1Cm5VJGZQRwlP5wac53Xmd44d7fP38+1kjlbCI8o54
	 V7Wb6I0UJ3uvS8WarALnqvjeoOLwBlbLXl7qz9yup5WcQcPlmDWgE/ikZ7vPVM3u2J
	 /gh/mscC5If5w==
Date: Wed, 10 Dec 2025 17:57:42 +0900
From: Jakub Kicinski <kuba@kernel.org>
To: "Behera, VIVEK" <vivek.behera@siemens.com>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Keller, Jacob
 E" <jacob.e.keller@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 iwl-net] igc: Fix trigger of incorrect irq in
 igc_xsk_wakeup function
Message-ID: <20251210175742.3dba9318@kernel.org>
In-Reply-To: <AS1PR10MB5392FCA415A38B9DD7BB5F218FA0A@AS1PR10MB5392.EURPRD10.PROD.OUTLOOK.COM>
References: <AS1PR10MB5392B7268416DB8A1624FDB88FA7A@AS1PR10MB5392.EURPRD10.PROD.OUTLOOK.COM>
	<4c90ed4e-307c-429a-9f8c-29032cc146ee@intel.com>
	<AS1PR10MB5392C71EED7AB2446036FB9F8FA3A@AS1PR10MB5392.EURPRD10.PROD.OUTLOOK.COM>
	<AS1PR10MB539202E6B3C43BE259831AD88FA3A@AS1PR10MB5392.EURPRD10.PROD.OUTLOOK.COM>
	<IA3PR11MB89863C74B0554055470B9EE0E5A3A@IA3PR11MB8986.namprd11.prod.outlook.com>
	<IA3PR11MB8986E4ACB7F264CF2DD1D750E5A0A@IA3PR11MB8986.namprd11.prod.outlook.com>
	<AS1PR10MB5392FCA415A38B9DD7BB5F218FA0A@AS1PR10MB5392.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Dec 2025 07:50:55 +0000 Behera, VIVEK wrote:
> Changes in v5:
> - Updated comment style from multi-star to standard /* */ as suggested by  Aleksandr.
> 
> From ab2583ff8a17405d3aa6caf4df1c4fdfb21f5e98 Mon Sep 17 00:00:00 2001
> From: Vivek Behera <vivek.behera@siemens.com>
> Date: Fri, 5 Dec 2025 10:26:05 +0100
> Subject: [PATCH v5] [iwl-net] igc: Fix trigger of incorrect irq in
>  igc_xsk_wakeup function

The formatting of your submissions is all wrong. And you don't follow
our guidance:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

Perhaps drop netdev@ and linux-kernel@ from the CC and Intel folks can
help guide/teach you on their own list. Until you have the posting
down..

