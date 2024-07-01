Return-Path: <netdev+bounces-108016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0E891D8E7
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 09:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348B0280BE5
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 07:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D2C6EB5B;
	Mon,  1 Jul 2024 07:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v6+i3bzi"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2F11B809
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 07:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818921; cv=none; b=DZRmUiTC4DcEtu/oZuCazQUmPwy3TmnZpdAW5Ldb/s8Q1SSvQg+0Je04ezHcwDihhFvVgD14YZOADU+5CNvmdieB8n/UF9motGKO9ugi5lh4rvygvvRwnODCoQbAMmuCRMs1913FpmLA9MXjdfbNRxEQKeDTTpQhfHKEg+dQTgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818921; c=relaxed/simple;
	bh=7RJjyJjpMrO6fjXjuoghE6frNsTONiAM7rGDqzTMckc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EA8bV0ibU/m6+wM3DOyj4phsexGGDDnPs3Z4h+TYrlT3AL8XzSRwMItWXkalhikanei04wE5n0lpzQ527CMzLgfTBg3dnhPvrkOzOVtPeV23pSN5SjfPTeqwcM79+TfGT1730Myl+Hrp9J3cpZHNy4eGaXXZM+WqQCq5qQ8JtMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v6+i3bzi; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 516C61140211;
	Mon,  1 Jul 2024 03:28:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 01 Jul 2024 03:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719818919; x=
	1719905319; bh=mTQAGaNhSn5eSAW7EUwcbfn0UJoMQP0fjC3lXf//TE4=; b=v
	6+i3bziR8c5mJQCjN3uAx1t0WOZbJ13iKYuz02du9XkvjHWxi04pW6NVFhx315w6
	layiNFINyB4PQVD9UOR4AVET4d/8qCdoHkoZgGzv5J650xsbra+YAkscVE90ibvI
	wUJOmeeXzb5cChYiEguqpVdJxyOnuylJYE4+w2u9QFpjCMaRUnjiVoLxjb9mqV+R
	+NrJd37EU8aFKDPeI7MEZrMETP2UwHDvDVnFYGJMYn4jFTudaHwea2zkDD5VFUeX
	FSXmgs1hmfygogJonqLZLizIM9R1dbDTXeWjS56Ur2ZyUTKtgG0w/EAj9ratRrDI
	1JzPDeWyj4FiQhegZYI5A==
X-ME-Sender: <xms:plqCZiO0nzhYaDHaNYKTAMSyVH6epru3Fpy4Fe8OZ2ykPJl8sNOsEw>
    <xme:plqCZg9BEUryS4NY-Ti2pU4sB96kT5hPAjrEz_ACvOJqpOIMSIhyCVKmPcpEXIseM
    8LXe1sTCxpadjc>
X-ME-Received: <xmr:plqCZpSFAP1zAPCFi3MZirhdL1LB2_k4n8f6QM1gjAJ8LSJaTDUg6g4Y3Haq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefkugho
    ucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrg
    htthgvrhhnpeduledvjeejhefgvdetheefheetjeejfeetjeevieejgfeujeffleffgeek
    ffeuieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhr
    gh
X-ME-Proxy: <xmx:plqCZitEj_LE7skDKgNkkFbD8WYCFoZ-n8tJn8-yoZO2FIVeJ3GjSg>
    <xmx:plqCZqdsJlyAa3YXp5mpaQKuzBv8i16ATCTj8GZ84LiygO-SXE9xkg>
    <xmx:plqCZm3p1D6fDGpfF41S3kQ3tqkaCvyAqBW9OAfDzWLMSjTlJd87Rw>
    <xmx:plqCZu_ieDO5bjII4vzDhbHhy1goeKNKSmbVzOWQ7mWUUfzQOZWO7A>
    <xmx:p1qCZrrHXegSKA3SaaeGOEA__6_kVVsMw-bW931Oxcw6af3OAyEL02WR>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jul 2024 03:28:37 -0400 (EDT)
Date: Mon, 1 Jul 2024 10:28:32 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Dan Merillat <git@dan.merillat.org>
Cc: Michal Kubecek <mkubecek@suse.cz>, netdev <netdev@vger.kernel.org>
Subject: Re: ethtool fails to read some QSFP+ modules.
Message-ID: <ZoJaoLq3sYQcsbDb@shredder.mtl.com>
References: <54b537c6-aca4-45be-9df0-53c80a046930@dan.merillat.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54b537c6-aca4-45be-9df0-53c80a046930@dan.merillat.org>

On Sun, Jun 30, 2024 at 01:27:07PM -0400, Dan Merillat wrote:
> 
> I was testing an older Kaiam XQX2502 40G-LR4 and ethtool -m failed with netlink error.  It's treating a failure to read
> the optional page3 data as a hard failure.
> 
> This patch allows ethtool to read qsfp modules that don't implement the voltage/temperature alarm data.

Thanks for the report and the patch. Krzysztof Olędzki reported the same
issue earlier this year:
https://lore.kernel.org/netdev/9e757616-0396-4573-9ea9-3cb5ef5c901a@ans.pl/

Krzysztof, are you going to submit the ethtool and mlx4 patches?

> From 3144fbfc08fbfb90ecda4848fc9356bde8933d4a Mon Sep 17 00:00:00 2001
> From: Dan Merillat <git@dan.eginity.com>
> Date: Sun, 30 Jun 2024 13:11:51 -0400
> Subject: [PATCH] Some qsfp modules do not support page 3
> 
> Tested on an older Kaiam XQX2502 40G-LR4 module.
> ethtool -m aborts with netlink error due to page 3
> not existing on the module. Ignore the error and
> leave map->page_03h NULL.

User space only tries to read this page because the module advertised it
as supported. It is more likely that the NIC driver does not return all
the pages. Which driver is it?

