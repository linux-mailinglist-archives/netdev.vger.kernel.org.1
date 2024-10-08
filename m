Return-Path: <netdev+bounces-133275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 920979956B8
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C351B1C24EB2
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC4B213EE7;
	Tue,  8 Oct 2024 18:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYuR77Mx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33FE213EE4;
	Tue,  8 Oct 2024 18:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412540; cv=none; b=bX5XKq9KOFo27eR3lTcaqqBftCEZrEhybw9yX/ED19sor/+hkoomFZVSJdctd6dnYy0iu9mLm1B+hXJ372eWq1auCtg9V574jrUnHRO9ck1iLtkK9E0D/uc6ejWq4dXppnnzadjU8CiHvtMpDU4xLxibngUW56Qfz1c9EUw913k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412540; c=relaxed/simple;
	bh=cvcljsQordzghArILPvKOFw4rLTtqx6ghKraH3FKXd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gIj/4G4bNDFxONgRBuTVlruDdBNSuJxF9/JqXJwXB6iPm2cJJo+hMTmh4pzwxriyJPkfxE3k8yL0W/RFxz1Rg5zl57XcCkyY9CBm4b+4HZwVragzYw52FNSLzHGCwtlwqgQliYptEqqQzV8bZxsEfAc0M6P/sNNNFOaF0RYfZzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYuR77Mx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06727C4CECF;
	Tue,  8 Oct 2024 18:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728412540;
	bh=cvcljsQordzghArILPvKOFw4rLTtqx6ghKraH3FKXd8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PYuR77MxCU2V4hog07JYMdNkork0DU4Kf8x1dKxJ8/agFUT66fsuPvoSnedD20Rl6
	 O3rRx6UNH5ypg+jjJwQE6wDKkE90y+wi03A/qhZlRY6QZ3mho4q5CmUcprh35hEla1
	 pVC0bSG4Tdi54tBZ9lWU5/ZafXJWxCUhM1wNcRojZ9w+jr+8xMFDgHe+b9zHOT/zd4
	 7wLSOisD0OHi2Acz5nfGHD8TSbRmInICl1WXDjo4epAhfpMcS8l/seDbazXKYFfxd1
	 0awhHgNceUiCU5TLDM4VzwlDsoXUxR5eMudCn3yt5GH38ywRGrf5zGTtHwJOGgUHr4
	 dPKiTMVQs5gCA==
Date: Tue, 8 Oct 2024 11:35:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 almasrymina@google.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com,
 kory.maincent@bootlin.com, andrew@lunn.ch, maxime.chevallier@bootlin.com,
 danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com,
 asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com,
 aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com,
 bcreeley@amd.com
Subject: Re: [PATCH net-next v3 4/7] bnxt_en: add support for
 tcp-data-split-thresh ethtool command
Message-ID: <20241008113538.5e920b12@kernel.org>
In-Reply-To: <20241003160620.1521626-5-ap420073@gmail.com>
References: <20241003160620.1521626-1-ap420073@gmail.com>
	<20241003160620.1521626-5-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu,  3 Oct 2024 16:06:17 +0000 Taehee Yoo wrote:
> +#define BNXT_HDS_THRESHOLD_MAX	256
> +	u16			hds_threshold;

=46rom the cover letter it sounded like the max is 1023.
Did I misread that ?

