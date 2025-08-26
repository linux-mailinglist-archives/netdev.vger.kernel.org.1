Return-Path: <netdev+bounces-217023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96231B37186
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 19:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6666189B0C2
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 17:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB962E3705;
	Tue, 26 Aug 2025 17:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmTeOrKE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2851E2BEFF7
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 17:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756230239; cv=none; b=Kc6+dB1xXi2lscKASiMg5hnG25futis978SBU7a1sLOISfEeLqMt0fdzc2sW9HuehXlA4+Jh2an22BuvZcmgfHusuMQB2xk7g2Kx6hEtxjFH5QGhKI4GTtDhVSdGOKJkagkHmyTFu3w1MttbAnc1ALOlxb5gmE4yLZGeeBpzNJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756230239; c=relaxed/simple;
	bh=KfIK98iHpFl4xX9GWUkDuIHW4w9/i0rlce5U2zyUgmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJAIVB2Zpy5fnjjXPUEYsGpTirfDfCyc6VIOCufUCy0LsvxOwGHER+YFtNN40IwjZf1dRQap6uH3YgML7/9VA/JDWxb548ign7R+3+BarWICdJVw+b1Az0FVdEdORhY7JlPR7Wv3aixqH+yno79svX46AmkOzsovWXGYmVIXaKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmTeOrKE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3041C4CEF1;
	Tue, 26 Aug 2025 17:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756230238;
	bh=KfIK98iHpFl4xX9GWUkDuIHW4w9/i0rlce5U2zyUgmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EmTeOrKEdtWN2VaptUpZAekTyCN40xu2K14Z7938FNUBbPVoO5g9eILWaSgHnLzsG
	 /C8M4L1dOmI7vNj16JAcNp4eGaUoqOHxRo4O7f6G0FgMjoaCSWrgNJ78fx9Q5SVghm
	 TEwHtdsnXLe/+ZzU5bq5nq4G8g3P8Fg4vFxyFXB5OecYNlQeWjiO3KpSvT2LBm5jsD
	 sZlemhGEDdBAAeH/Y9qUfxakNAzBRsKUWpd3vsczrjC4LjP6LblSPt26YFe50JC2xV
	 91UPbPq0rzjz8va0VZGgrf6PesVM8Z/WAUpvl8oa4GAV63F3OG9GCpnRfim/MJodr6
	 kn1pJV6lPVHPQ==
Date: Tue, 26 Aug 2025 18:43:53 +0100
From: Simon Horman <horms@kernel.org>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Aleksandr.Loktionov@intel.com, przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jianliu@redhat.com, mschmidt@redhat.com,
	decot@google.com, willemb@google.com, joshua.a.hay@intel.com,
	pmenzel@molgen.mpg.de
Subject: Re: [PATCH iwl-net v3] idpf: set mac type when adding and removing
 MAC filters
Message-ID: <20250826174353.GN5892@horms.kernel.org>
References: <20250814234300.2926-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814234300.2926-1-emil.s.tantilov@intel.com>

On Thu, Aug 14, 2025 at 04:43:00PM -0700, Emil Tantilov wrote:
> On control planes that allow changing the MAC address of the interface,
> the driver must provide a MAC type to avoid errors such as:
> 
> idpf 0000:0a:00.0: Transaction failed (op 535)
> idpf 0000:0a:00.0: Received invalid MAC filter payload (op 535) (len 0)
> idpf 0000:0a:00.0: Transaction failed (op 536)
> 
> These errors occur during driver load or when changing the MAC via:
> ip link set <iface> address <mac>
> 
> Add logic to set the MAC type when sending ADD/DEL (opcodes 535/536) to
> the control plane. Since only one primary MAC is supported per vport, the
> driver only needs to send an ADD opcode when setting it. Remove the old
> address by calling __idpf_del_mac_filter(), which skips the message and
> just clears the entry from the internal list. This avoids an error on DEL
> as it attempts to remove an address already cleared by the preceding ADD
> opcode.
> 
> Fixes: ce1b75d0635c ("idpf: add ptypes and MAC filter support")
> Reported-by: Jian Liu <jianliu@redhat.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Reviewed-by: Simon Horman <horms@kernel.org>


