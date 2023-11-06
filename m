Return-Path: <netdev+bounces-46277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA89A7E302A
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 23:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45761280D49
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 22:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769FF2D057;
	Mon,  6 Nov 2023 22:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkCTUa90"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4563C1CF95;
	Mon,  6 Nov 2023 22:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C08AC433C8;
	Mon,  6 Nov 2023 22:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699311072;
	bh=hkvTsG9pQBZJgKphLFlecoFHv4ayJ5t6MVgsEW+7phQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YkCTUa90IHceig8zgubDH+PA7TtDpZKeOWOPtW6rh3rgsaBaUKu8MnjQiszZ1e0iQ
	 OePGe7GwGsfLf8J3FFTF1J9F0MBeASANGIPFsDhDvW0fQ/A+1eUpZfRNG0ojccYDz/
	 IXEdjwAdey4LJ9GQgBWlqbd/oDGav9i9dwbrGDplGW6Q8f++uT/mOhojStBn/03Bh5
	 wOMJWiZwDKDfFjceTU193Tk1dZH+eOK7uO4PIu5q7U/A+fUQDxuboujjNVcCFZ41fN
	 qS59i4xWrqgaZtpxMa9bklIuqlPIy8N3Ak5Jy+9lrsJT00g0RHvjkPw1ZJwQmMIlBX
	 zk2y1LNjK6PMA==
Date: Mon, 6 Nov 2023 14:51:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH] Documentation: Document the Netlink spec
Message-ID: <20231106145111.3537538f@kernel.org>
In-Reply-To: <20231103135622.250314-1-leitao@debian.org>
References: <20231103135622.250314-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Nov 2023 06:56:22 -0700 Breno Leitao wrote:
> This is a Sphinx extension that parses the Netlink YAML spec files
> (Documentation/netlink/specs/), and generates a rst file to be
> displayed into Documentation pages.
> 
> Create a new Documentation/networking/netlink_spec page, and a sub-page
> for each Netlink spec that needs to be documented, such as ethtool,
> devlink, netdev, etc.
> 
> Create a Sphinx directive extension that reads the YAML spec
> (located under Documentation/netlink/specs), parses it and returns a RST
> string that is inserted where the Sphinx directive was called.

> +=======================================
> +Family ``fou`` netlink specification
> +=======================================

nit: bad length of the ==== marker lines

> +def parse_attributes_set(entries: List[Dict[str, Any]]) -> str:

I'd rename to parse_attr_sets (plural sets).

> +    """Parse attribute from attribute-set"""
> +    preprocessed = ["name", "type"]
> +    ignored = ["checks"]
> +    lines = []
> +
> +    for entry in entries:
> +        lines.append(rst_bullet(bold(entry["name"])))

This would be better as subsubtitle.

> +        for attr in entry["attributes"]:
> +            type_ = attr.get("type")
> +            attr_line = bold(attr["name"])
> +            if type_:
> +                # Add the attribute type in the same line
> +                attr_line += f" ({inline(type_)})"
> +
> +            lines.append(rst_bullet(attr_line, 2))

And this actually, probably also a sub^3-title, because we'll want to
link to the specific attributes sooner or later. And linking to bullet
points isn't a thing (AFAIU?)

