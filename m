Return-Path: <netdev+bounces-28123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920FC77E4BF
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 17:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCD3281AEB
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 15:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DEA156CE;
	Wed, 16 Aug 2023 15:12:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E83310957
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 15:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039DFC433C7;
	Wed, 16 Aug 2023 15:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692198730;
	bh=4umvi0Zd4qyu8CE0DXTGHbHgH3ugeqP0mZ6kaZi1KiY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=snwyMyXUWaq02SFi54cPvrQz8A+ioAg7hJlPnUY+jSDRIbvRmHrqoPycpHq6tcmEH
	 4+q9YaCVERFoN24i+gZvjtqNXh4xJk6JkaJ+yCl7GnNILjuokxOD7CVb1MNEZJv96A
	 Pbu7Z084TBuNp4W4XzFB/ijZXeQ8nY+6FazPYXEsEFMNlvQqk3rJqwos4qRvnKpO/h
	 ClsF/mBM2w2sf4P5u9XuchePTIb5DhpDfV51zTzWdmWw4ex/r8kJaHxBpQIf0rDoO8
	 3XuHxdqF9mZ3iThQroSgcr2Cnw3PNbmNpO3SweLNr5LaVXLjFU6bVFEk7teimg+N4+
	 w1Yv4C/tUuJpA==
Date: Wed, 16 Aug 2023 08:12:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Stanislav Fomichev
 <sdf@google.com>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 04/10] tools/ynl: Add mcast-group schema
 parsing to ynl
Message-ID: <20230816081209.56b48f07@kernel.org>
In-Reply-To: <20230815194254.89570-5-donald.hunter@gmail.com>
References: <20230815194254.89570-1-donald.hunter@gmail.com>
	<20230815194254.89570-5-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Aug 2023 20:42:48 +0100 Donald Hunter wrote:
> +class SpecMcastGroup(SpecElement):
> +    """Netlink Multicast Group
> +
> +    Information about a multicast group.

I'd add more info about value here. Say something along the lines
of value is specified in the spec only for classic netlink
(netlink-raw) families, genetlink families use dynamic ID allocation
so the ids of multicast groups need to be resolved at runtime.
value will be None for genetlink families.

> +
> +    Attributes:
> +        name      name of the mulitcast group
> +        value     numerical id of this multicast group for netlink-raw
> +        yaml      raw spec as loaded from the spec file
> +    """
> +    def __init__(self, family, yaml):
> +        super().__init__(family, yaml)
> +        self.value = self.yaml.get('value')

