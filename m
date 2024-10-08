Return-Path: <netdev+bounces-133243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE644995636
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2F91C25607
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CD7210C35;
	Tue,  8 Oct 2024 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnM/2TXH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B57C1E0DA6;
	Tue,  8 Oct 2024 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411060; cv=none; b=qO5e8NUHQx2kSOS1I0BbhsyVxaetczF8D3HTAK0xDDBQIXpE98KELMecnS8r28FS4YAxmgmkG30ndotyGqR3MoG1ZlmWmgwxdkvPSeCqBQWjJhmPnOgzh2yiCLrDhYNlqcQzFOIEQE5d74T2AYEQsCNjb9fdvOwfXSo6hzKLl4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411060; c=relaxed/simple;
	bh=MbMTSNqZzM4SxVJANc6XegOhzQ6LafbFHlx1C1gQ+ks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvLVQUE/RUKw3K7qgFi0ZhFOwh42wjyNeFOq7v2MhFRRcqmoq1aDDKWYJVDxFTaVoWGKSM/vArmztZMnWx9oF2WQSxyrxtnqfc9VjQM39I13PmJR/BvO9T8aTR7WopL7yCjCx30H9P9MTjmIxXY6NRsDvzPbye3HzYz28qdcHnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnM/2TXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4062C4CEC7;
	Tue,  8 Oct 2024 18:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728411060;
	bh=MbMTSNqZzM4SxVJANc6XegOhzQ6LafbFHlx1C1gQ+ks=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mnM/2TXH+aWz/XBoQvllNsymvF3HfbOKrm+prLlYsa/S4whoOBQni3gxrP6ufY0NN
	 MPsIzv0Hg+3zQDXnNZZdOjatXiCvEV9ST2v0XF5i5sdUvitDZRIo8g/EMiC1Pyi0v0
	 E0QnD0v3NZM1ZABJPj7Ou7FM1qzeZFfErGZI3T3HhDmVUwztPX5ErXBVfu/s3lGENR
	 qlFXlXWyXiF1tYV8BmTJKNqQ0B48Jk3oumwzAJ6SxSR0o8d6Fp8lRwyXXCSFKpZINA
	 MxcqcvGW0s/IZb5mn+QL0SkGYZUvgMoQTRfSpCZuAZcCa8OAM6gkZCSBIRFV/79nDF
	 ushYH98ZAczSA==
Date: Tue, 8 Oct 2024 11:10:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 almasrymina@google.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 donald.hunter@gmail.com, corbet@lwn.net, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, danieller@nvidia.com,
 hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com,
 asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com,
 aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com,
 bcreeley@amd.com
Subject: Re: [PATCH net-next v3 1/7] bnxt_en: add support for rx-copybreak
 ethtool command
Message-ID: <20241008111058.6477e60c@kernel.org>
In-Reply-To: <CAMArcTUgDLawxxvFKsfavJiBs0yrEBD3rZOUcicYOAWYr+XYyQ@mail.gmail.com>
References: <20241003160620.1521626-1-ap420073@gmail.com>
	<20241003160620.1521626-2-ap420073@gmail.com>
	<CACKFLi=1h=GBq5bN7L1pq9w8cSiHA16CZz0p8HJoGdO+_5OqFw@mail.gmail.com>
	<CAMArcTXUjb5XuzvKx03_xGrEcA4OEP6aXW2P0eCpjk9_WaUS8Q@mail.gmail.com>
	<CACKFLikCqgxTuV1wV4m-kdDvXhiFE7P=G_4Va_FmPsui9v2t4g@mail.gmail.com>
	<a3bd0038-60e0-4ffc-a925-9ac7bd5c30ae@lunn.ch>
	<CAMArcTUgDLawxxvFKsfavJiBs0yrEBD3rZOUcicYOAWYr+XYyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 5 Oct 2024 15:29:54 +0900 Taehee Yoo wrote:
> > > I think a single value of 0 that means disable RX copybreak is more
> > > clear and intuitive.  Also, I think we can allow 64 to be a valid
> > > value.
> > >
> > > So, 0 means to disable.  1 to 63 are -EINVAL and 64 to 1024 are valid.  Thanks.  
> >
> > Please spend a little time and see what other drivers do. Ideally we
> > want one consistent behaviour for all drivers that allow copybreak to
> > be disabled.  
> 
> There is no specific disable value in other drivers.
> But some other drivers have min/max rx-copybreak value.
> If rx-copybreak is low enough, it will not be worked.
> So, min value has been working as a disable value actually.
> 
> I think Andrew's point makes sense.
> So I would like to change min value from 65 to 64, not add a disable value.

Where does the min value of 64 come from? Ethernet min frame length?

IIUC the copybreak threshold is purely a SW feature, after this series.
If someone sets the copybreak value to, say 13 it will simply never
engage but it's not really an invalid setting, IMHO. Similarly setting
it to 0 makes intuitive sense (that's how e1000e works, AFAICT).

