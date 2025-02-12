Return-Path: <netdev+bounces-165634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953E0A32E34
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 19:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337493A83A8
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 18:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C35425C709;
	Wed, 12 Feb 2025 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IH8Si3Ya"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426A724C663;
	Wed, 12 Feb 2025 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384040; cv=none; b=in+IZEDETuTGLdQFR/EL1yT+XwerLVUYwjI9dK2W1o+7mlquw3YQU/AXPHLuoj0thqKsXYLpvnazHvI2AHjUvfoHL9pRNPuucyjOkV3niA87FpsILREhaqC9CouYL1SVWWSLqdibeOKO2WJW47rOp/U6QlvLvzYpriPvbHy+RtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384040; c=relaxed/simple;
	bh=R4hi+loSX6nK9PyvVP+6F+yJnOoSoHMlJsunZsdz6yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqwKAuyILXThcVsrdPD9HuFgyK4E4gfrIEqc2IkmbT9h2fA4pnhB6qvS7XiUPszh9GVg78qiBT42WYPy0fbkC48aHjVDquERvhOe3bmzXCYTfwFUVbuZT0kkJwUpju2YtEEIhvPr8eoln2Y/UF76ZZVn6xrunKoWdA2YfsqadOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IH8Si3Ya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2634C4CEDF;
	Wed, 12 Feb 2025 18:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739384039;
	bh=R4hi+loSX6nK9PyvVP+6F+yJnOoSoHMlJsunZsdz6yU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IH8Si3Ya12B08y7lEHGlErVJRKN6yLUwzpio5MvH2JH03nSWKQmq4qLBdFVo7+CoL
	 +aAfjhdFowceBiXcjte5SbZ756VaFpSTj2CYsLCGJg2FOV+xNb5srGsqMH/L+diat1
	 EuZGe2hIvhgf89w0InGJaeI/LAz5SNdfsz0BqdKH++4US3o73gL+oXhD3BORB63I4D
	 1TZfaF2/w0mMt2K8/NHoegZkyx/l7xJigIGDUj2aMjk9H5U6jqmEMDb92XsLTJO4il
	 DgwWIn3wmwXcZfostQF4RP7bgPh2UxujjqmCI1jDie+ey+oLiYZlfsDxXXanXr3o+U
	 2W+fdJx1IMYvQ==
Date: Wed, 12 Feb 2025 10:13:58 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tariq Toukan <tariqt@nvidia.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] Symmetric OR-XOR RSS hash
Message-ID: <Z6zk5qMCP1juVN6o@x130>
References: <20250205135341.542720-1-gal@nvidia.com>
 <20250206173225.294954e2@kernel.org>
 <191d5c1c-7a86-4309-9e74-0bc275c01e45@nvidia.com>
 <20250210162725.4bd38438@kernel.org>
 <68e2a8cc-2371-433b-86a3-ac9dea48fb43@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <68e2a8cc-2371-433b-86a3-ac9dea48fb43@nvidia.com>

On 11 Feb 17:26, Gal Pressman wrote:
>On 11/02/2025 2:27, Jakub Kicinski wrote:
>> On Sun, 9 Feb 2025 09:59:22 +0200 Gal Pressman wrote:
>>> I don't understand the rationale, the new input_xfrm field didn't
>>> deserve a selftest, why does a new value to the field does?
>>
>> Ahmed and Sudheer added ETHTOOL_MSG_RSS_GET as part of their work.
>> Everyone pays off a little bit of technical debt to get their
>> feature in.
>
>I agree with the idea that extensions to ethtool uapi should be
>accompanied by conversion to netlink.
>
>I don't see a connection to testing. If a maintainer has certain
>expectations about which changes require tests, it should be documented
>and enforced so it's not up to the maintainer's mood. FWIW, I don't
>believe kernel contributions should be blocked by lack of a test.
>
>>
>> I don't appreciate your reaction. Please stop acting as if nVidia was
>> a victim of some grand conspiracy within netdev.

The main problem is the tone in theses responses, we appreciate your
reviews and comments, but sometimes the responses and comments are a
bit too hostile.

>
>I don't know what you're talking about, you've mistaken me for someone
>else..
>

Misunderstanding ? ..

Gal's response was technical, objective and free from any "I'm a victim"
complaints, so I get why he's confused.

I understand that there's some friction going on with a few nVidia WIP
features, but there's no reasons for comments and reactions to not remain
in the technical realm.

Anyway I am happy to discuss all open issues and misunderstandings offline.
All we need is to just align expectations and work towards a shared plan
and a maintainer vs contributor friendly policy.

LKM.



