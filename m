Return-Path: <netdev+bounces-92296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5585D8B67C1
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 03:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E574B20D0E
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 01:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CB46FB0;
	Tue, 30 Apr 2024 01:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbmBjX7k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B014E8F49
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 01:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714442383; cv=none; b=elRK4r1Wfg7HTyUhC0xWx+QH7TBH/6f6x/bMnqAa7VHlqA6uoaA3RaP1KOx/LPcLGzHAQL6KD4nw3ztxL7l+7KDwh8iz0lEobgic1n3BJq959IqUx9nex7RGbiSEmJy5QpiUPpBf8GGhva/Q6aHWvZIxSMV7RwmW0O8vzACYHF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714442383; c=relaxed/simple;
	bh=gmJV+eyXc5ullhBIXnJzh6zZc8wBJRfAl36OX7QTHVY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLAm/1XpySHXvA2EwHdlTCCTt9eWzFBhaMJbireHNI1U3fzzyB7IjXEDrxICZE2dpM1G/Va374Juo9M2Y63xBg2TK7N7r5uCIcfOIAmjcYPVwyT5DO51b8TSQed+BZeckNhQWQW6g6YRodRkNgGEK67Xy2cR4i+8yLU+eilIe9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbmBjX7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9DFC116B1;
	Tue, 30 Apr 2024 01:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714442383;
	bh=gmJV+eyXc5ullhBIXnJzh6zZc8wBJRfAl36OX7QTHVY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bbmBjX7kooxLeXCyoVnwZrgSBAgmhglSG6Cx0wtC+TYnkdSOo6h4SSp5csL91Q17E
	 i8S5aFbNfT/17PyFCclVWqBz2qfGYiy+m4nyAtxvDH/o9p/0OrNoU7cLLVJdNTiI/F
	 Bptd0ku/N4bcdzh/m74Inall2DhFYwmjNyrrgmvOKVsVrgpSoioPXtiClC0ocYDlQd
	 cBC2tpQtfqoMayK9C0xJGlinzk7s9HwXGhiwbzG4aJFKUo4qQQ5+YYL60KnWgNi63L
	 HtIbEqnmRU58O+T3e1e+lYj3toh59gg3vsWvUI2zzV7cBY4y9JfyNq1WpebNbErdaD
	 YjzXJqbaaoXxw==
Date: Mon, 29 Apr 2024 18:59:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Knitter, Konrad" <konrad.knitter@intel.com>, "Samudrala, Sridhar"
 <sridhar.samudrala@intel.com>, "Brandeburg, Jesse"
 <jesse.brandeburg@intel.com>, Mateusz Polchlopek
 <mateusz.polchlopek@intel.com>, Ahmed Zaki <ahmed.zaki@intel.com>, "Simon
 Horman" <horms@kernel.org>, Michal Schmidt <mschmidt@redhat.com>, Paolo
 Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Pawel Chmielewski
 <pawel.chmielewski@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>
Subject: Re: [RFC net-next (what uAPI?) ice: add support for more than 16
 RSS queues for VF
Message-ID: <20240429185941.6229b944@kernel.org>
In-Reply-To: <73ac167e-abc5-4e7b-96e3-7c6689b5665a@intel.com>
References: <73ac167e-abc5-4e7b-96e3-7c6689b5665a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Apr 2024 15:22:02 +0200 Przemek Kitszel wrote:
> ## devlink resources (with current API)
> `devlink resource` is compelling, partially given the name sounds like a
> perfect match. But when we dig just a little bit, the current Path+sizes
> (min,max,step) is totally off to what is the most elegant picture of the
> situation. In order to fit into existing uAPI, I would need to register
> VFs as PF's resource, then GLOBAL LUT and PF LUT as a sub resource to
> that (each VF gets two entries under it; plus two additional ones for
> PF) I don't like it, I also feel like there is not that much use of
> current resources API (it's not natural to use it for distribution, only
> for limitation).

Can you share more on how that would look like?=20

=46rom the description it does not sound so bad. Maybe with some CLI / UI
changes it will be fine?

> ## devlink resources (with extended API)
> It is possible to extend current `devlink resource` so instead of only
> Path+size, there would be also Path+Owner option to use.
> The default state for ice driver would be that PFs owns PF LUTs, GLOBAL
> LUTs are all free.
>=20
> example proposed flow to assign a GLOBAL LUT to VF0 and PF LUT to VF1:
> pf=3D0000:03:00.0  # likely more meaningful than VSI idx, but open for
> vf0=3D0000:03:00.1 #                                       suggestions
> vf1=3D0000:03:00.2
> devlink resource set pci/$pf path /lut/lut_table_512 owner $pf
> devlink resource set pci/$pf path /lut/lut_table_2048 owner free
> devlink resource set pci/$pf path /lut/lut_table_512 owner $vf0
> devlink resource set pci/$pf path /lut/lut_table_2048 owner $vf1

Don't we want some level of over-subscription to be allowed?

