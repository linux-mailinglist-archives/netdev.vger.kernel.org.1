Return-Path: <netdev+bounces-113518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2765293ED7D
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 08:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FEF282B2E
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 06:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB21E7F47F;
	Mon, 29 Jul 2024 06:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ntaxvL/M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FC333CD2
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 06:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722234658; cv=none; b=LLMteLv6hHnl6V6z3wlLX1ad8lnK7tafQV7CR/Lz6uEg3OP5Qr1AF+w24LBQ2gtxoxWCt+4QoDIj6rt2M/jIGHquzmkY0w1ADfpVzZfRPKPDh25ilopNT73H+NdHJ/S17YnevgCvxtTd8yrWT595hxmfcWeQsSJVapZkhdGYp0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722234658; c=relaxed/simple;
	bh=2s+0mHeVOjTsGBCtvXLo/4yP+h6JygsGICNUAUrA4Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9kAX7pi3J8RFAuTR5lTeCU0Sa06gT/pmTcLEk4Urbfkxg5X0KPIDpH10wPvWUPL7nh33xeeJzfo9ItTVu1beSKG+CmOwb976Y0X1aHIDCxoRX0enRH5gL2oJCww7hTJaQXdR9l7QvFb7Xif0dEUSmI3O2xpHCjIy5i+QyCSrDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ntaxvL/M; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a728f74c23dso435472066b.1
        for <netdev@vger.kernel.org>; Sun, 28 Jul 2024 23:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722234654; x=1722839454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AttycvVFkX3BsskDuWttZQc4g3E8OZ0SBQnl7WxXnrI=;
        b=ntaxvL/MdxaODqEDVyiZmXk3oAzUASgSu8t3TMKRU3U6mnq+4Wv3b0VibC3L3wv7ew
         1gT2V7jOW5pp3n46X+10PHkgbZhD+8FdczkoE+TCKeFVnXEFaK1EphAlumE+2wvlrfeN
         amk1MQdkskWo0vTClW0KCCnKc/leCAnvSn85tZSfEeaACbF/irfzk0JkUQyF5SKLJtMB
         B1flIQ79GRj35jW0nS5mndUdO0FAnTWK+Dn2Zg+tJL5L5sENdG6pVelPMnIVGkVH8t+e
         vQqm9h5IbvzuXqpCpsXE73l+pjdB95EW1U2XKZb9oRPRGEtYyLhs7wjIcdz9qFJc7o/b
         QLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722234654; x=1722839454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AttycvVFkX3BsskDuWttZQc4g3E8OZ0SBQnl7WxXnrI=;
        b=LXT5aeyvLTfJR7+K0iOiR3FbFtV4L185qzthJwBUp5AnTjU+bED8pPu5/zA6slIol2
         PU9IxID9g2210+3fn7NfC8mc4bOFxZ7aq4h9axe92vK/u2AzjIogQSSJQap/OvD4cFK8
         nO8Ws+PjkDiTdoRCpPvnhXEx436jyaxLOrCaf2JIYi7wvrW/+lpLP/rGHKbVKw5T4WR6
         raMRAWHpSbTW+w0Zj0NmccNR0hEhYHvv7j9HtBxoeNWBjF6xTNPbVIQ2MtRl9PCcY95P
         RJ/Al1uOqkdNiv4ZcxBPvtUwQIl3QUKFti+1XpQipJRc7Dj/Sl/cdsLpWY6sK4ud5VIS
         RgxA==
X-Gm-Message-State: AOJu0YxOs7mARSwotPOlzrX3DyCIBztk/Fux0kT5kGhJ6zkG7pTdZM9k
	SPO0vek4lW2UHw0jU1DNCqHQQEx/o8R8xy+QiggpjwibQ//tHBJGinTQlxgsvkY=
X-Google-Smtp-Source: AGHT+IFvMYQnY/qCjUiRKsDVhX/Yrwi7kVX/xX8H4vqi++N4B+FbojxmYT4ReljSxHtNQ8qk1i4mRw==
X-Received: by 2002:a17:907:3da8:b0:a7a:b18a:66 with SMTP id a640c23a62f3a-a7d40042959mr468125866b.16.1722234653474;
        Sun, 28 Jul 2024 23:30:53 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad91080sm467265666b.160.2024.07.28.23.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 23:30:52 -0700 (PDT)
Date: Mon, 29 Jul 2024 08:30:51 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH RFC v2 00/11] net: introduce TX shaping H/W offload API
Message-ID: <Zqc3Gx8f1pwBOBKp@nanopsycho.orion>
References: <cover.1721851988.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721851988.git.pabeni@redhat.com>

Wed, Jul 24, 2024 at 10:24:46PM CEST, pabeni@redhat.com wrote:
>We have a plurality of shaping-related drivers API, but none flexible
>enough to meet existing demand from vendors[1].
>
>This series introduces new device APIs to configure in a flexible way
>TX shaping H/W offload. The new functionality is exposed via a newly

From what I understand, and please correct me if I'm wrong, this
patchset is about HW shaper configuration. Basically it provides new UAPI
to configure the HW shaper. So Why you say "offload"? I don't see
anything being offloaded here.

Also, from the previous discussions, I gained impression that the goal
of this work is to replace multiple driver apis for the shaper and
consolidate it under new one. I don't see anything like this in this
patchset. Do you plan it as a follow-up? Do you have RFC for that step
as well?


>defined generic netlink interface and includes introspection
>capabilities. Some self-tests are included, on top of a dummy
>netdevsim implementation, and a basic implementation for the iavf
>driver.
>
>Some usage examples:
>
>* Configure shaping on a given queue:
>
>./tools/net/ynl/cli.py --spec Documentation/netlink/specs/shaper.yaml \
>	--do set --json '{"ifindex":'$IFINDEX',
>			"shaper": {"handle":
>				{"scope": "queue", "id":'$QUEUEID' },
>			"bw-max": 2000000 }}'
>
>* Container B/W sharing
>
>The orchestration infrastructure wants to group the 
>container-related queues under a RR scheduling and limit the aggregate
>bandwidth:
>
>./tools/net/ynl/cli.py --spec Documentation/netlink/specs/shaper.yaml \
>	--do group --json '{"ifindex":'$IFINDEX', 
>			"inputs": [ 
>			  {"handle": {"scope": "queue", "id":'$QID1' },
>			   "weight": '$W1'}, 
>			  {"handle": {"scope": "queue", "id":'$QID2' },
>			   "weight": '$W2'}], 
>			  {"handle": {"scope": "queue", "id":'$QID3' },
>			   "weight": '$W3'}], 
>			"output": { "handle": {"scope":"netdev"},
>			"output": { "handle": {"scope":"netdev"},
>			   "bw-max": 10000000}}'
>{'handle': {'id': 0, 'scope': 'netdev'}}
>
>* Delegation
>
>A container wants to set a B/W limit on 2 of its own queues:
>
>./tools/net/ynl/cli.py --spec Documentation/netlink/specs/shaper.yaml \
>	--do group --json '{"ifindex":'$IFINDEX', 
>			"inputs": [ 
>			  {"handle": {"scope": "queue", "id":'$QID1' },
>			   "weight": '$W1'}, 
>			  {"handle": {"scope": "queue", "id":'$QID2' },
>			   "weight": '$W2'}], 
>			"output": { "handle": {"scope":"detached"},
>			   "bw-max": 5000000}}'
>{'handle': {'id': 0, 'scope': 'detached'}}
>
>* Cleanup:
>
>Deleting a single queue shaper:
>
>./tools/net/ynl/cli.py --spec Documentation/netlink/specs/shaper.yaml \
>	--do delete --json \
>	'{"ifindex":'$IFINDEX', 
>	  "handle": {"scope": "queue", "id":'$QID1' }}'
>
>Deleting the last shaper under a group deletes the group, too:
>
>./tools/net/ynl/cli.py --spec Documentation/netlink/specs/shaper.yaml \
>	--do delete --json \
>	'{"ifindex":'$IFINDEX', 
>	  "handle": {"scope": "queue", "id":'$QID2' }}'
>./tools/net/ynl/cli.py --spec Documentation/netlink/specs/shaper.yaml \
>        --do get --json '{"ifindex":'$IF', 
>			  "handle": { "scope": "detached", "id": 0}}'
>Netlink error: Invalid argument
>nl_len = 80 (64) nl_flags = 0x300 nl_type = 2
>	error: -22
>	extack: {'msg': "Can't find shaper for handle 10000000"}
>
>Changes from RFC v1:
> - set() and delete() ops operate on a single shaper
> - added group() op to allow grouping and nesting
> - split the NL implementation into multiple patches to help reviewing
>
>RFC v1: https://lore.kernel.org/netdev/cover.1719518113.git.pabeni@redhat.com/
>
>[1] https://lore.kernel.org/netdev/20240405102313.GA310894@kernel.org/
>
>Paolo Abeni (7):
>  netlink: spec: add shaper YAML spec
>  net-shapers: implement NL get operation
>  net-shapers: implement NL set and delete operations
>  net-shapers: implement NL group operation
>  netlink: spec: add shaper introspection support
>  net: shaper: implement introspection support
>  testing: net-drv: add basic shaper test
>
>Sudheer Mogilappagari (2):
>  iavf: Add net_shaper_ops support
>  iavf: add support to exchange qos capabilities
>
>Wenjun Wu (2):
>  virtchnl: support queue rate limit and quanta size configuration
>  ice: Support VF queue rate limit and quanta size configuration
>
> Documentation/netlink/specs/shaper.yaml       | 337 ++++++
> Documentation/networking/kapi.rst             |   3 +
> MAINTAINERS                                   |   1 +
> drivers/net/Kconfig                           |   1 +
> drivers/net/ethernet/intel/Kconfig            |   1 +
> drivers/net/ethernet/intel/iavf/iavf.h        |  13 +
> drivers/net/ethernet/intel/iavf/iavf_main.c   | 215 +++-
> drivers/net/ethernet/intel/iavf/iavf_txrx.h   |   2 +
> .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 157 ++-
> drivers/net/ethernet/intel/ice/ice.h          |   2 +
> drivers/net/ethernet/intel/ice/ice_base.c     |   2 +
> drivers/net/ethernet/intel/ice/ice_common.c   |  21 +
> .../net/ethernet/intel/ice/ice_hw_autogen.h   |   8 +
> drivers/net/ethernet/intel/ice/ice_txrx.h     |   1 +
> drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
> drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   8 +
> drivers/net/ethernet/intel/ice/ice_virtchnl.c | 333 ++++++
> drivers/net/ethernet/intel/ice/ice_virtchnl.h |  11 +
> .../intel/ice/ice_virtchnl_allowlist.c        |   6 +
> drivers/net/netdevsim/netdev.c                |  37 +
> include/linux/avf/virtchnl.h                  | 119 +++
> include/linux/netdevice.h                     |  17 +
> include/net/net_shaper.h                      | 169 +++
> include/uapi/linux/net_shaper.h               |  91 ++
> net/Kconfig                                   |   3 +
> net/Makefile                                  |   1 +
> net/core/dev.c                                |   2 +
> net/core/dev.h                                |   6 +
> net/shaper/Makefile                           |   9 +
> net/shaper/shaper.c                           | 962 ++++++++++++++++++
> net/shaper/shaper_nl_gen.c                    | 142 +++
> net/shaper/shaper_nl_gen.h                    |  30 +
> tools/testing/selftests/drivers/net/Makefile  |   1 +
> tools/testing/selftests/drivers/net/shaper.py | 267 +++++
> .../testing/selftests/net/lib/py/__init__.py  |   1 +
> tools/testing/selftests/net/lib/py/ynl.py     |   5 +
> 36 files changed, 2983 insertions(+), 2 deletions(-)
> create mode 100644 Documentation/netlink/specs/shaper.yaml
> create mode 100644 include/net/net_shaper.h
> create mode 100644 include/uapi/linux/net_shaper.h
> create mode 100644 net/shaper/Makefile
> create mode 100644 net/shaper/shaper.c
> create mode 100644 net/shaper/shaper_nl_gen.c
> create mode 100644 net/shaper/shaper_nl_gen.h
> create mode 100755 tools/testing/selftests/drivers/net/shaper.py
>
>-- 
>2.45.2
>

