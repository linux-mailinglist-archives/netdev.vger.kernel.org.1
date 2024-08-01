Return-Path: <netdev+bounces-114944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91127944BD0
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE691C228F9
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 12:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82FC1A01B7;
	Thu,  1 Aug 2024 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="W64e7suj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FC2158A2C
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517029; cv=none; b=T7YkvO/0vv+jguwcF9HN4haXBvk9/AShbUoYhbmEZDW1wAfv354rj2NnNAlfA671Hqk35VeXBaIEMqnaF0B9+ynIm11OgxZpoac/yOvLDBEwlSbfCLu0w8VtoPXbGo1AXfH9cQkX4r3ehqJE2NoemvDeZ+2esDP7bnZNhjRgY2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517029; c=relaxed/simple;
	bh=lW3EWO3jOenR9p6mtYmCnqMFgRpUWIDMxvz0ImNP5Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j83KVwyN9NsAhpJv74AvOh/nHGAzJb8DwOJY/vg8pTd5jAWs8qw/C4/hAIse2S4bngAHvkUJTj5OkQbh/lwrhhG/LTim59JzcYY10rKzoozS6vM2/llriRQHerRWW8oDudMmiMicxRslxeWOERAm0IgYGWz00WPLGx7+dG1d4HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=W64e7suj; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eeb1ba040aso112163111fa.1
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 05:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722517025; x=1723121825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/DIMMSWIiXgPAMWA/YMJYURb9dUJVUxyj4oY3QhI1lA=;
        b=W64e7sujsEYhaWlN9ePOlHylmWSX7yZtzZD9eiBUQlD21W7PxE+wAa4eklbwPnLkPB
         Yh0WhyS8q8afY/BdXq2WjHxz3uy/L5o/WRl8HnQosVkqtV8h5YHBo7H+Nb+mtc3VipQr
         +djGobSF7OAh6TRTdIOWrDNNHBM8PHqS8GsTmshfijULc+HlO7wj3+cjmTpKSUcjOUIU
         ZwI+NG3OI5lJk4WAVa8PGgXI1asfX7+nlCDYdO1ifPf7B4Am1tqtqHWqxrWz7/NIRupy
         dA3AMbHVgMfmtju1YnAHRJl/vNhEDkrM9GbDhstzYj/rVDEmgZl8ktrpB6wO2OFBbbqN
         EJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722517025; x=1723121825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DIMMSWIiXgPAMWA/YMJYURb9dUJVUxyj4oY3QhI1lA=;
        b=e3A+2KgFZrv6SUZf7/jp8YSmQc2dh1CV1Ltod6yQGUyQHcFZNSNTni7FuGjKJf9Ezl
         Nxh/yc6e2WsP8Y7GeELZXdqgVLwtxREoQDVosaRBTihYm83xiwH2UyEzlFR0W0qzKJK0
         modL0drtWjlFW+rcmNVBPXoUbaNqpigJYalTgjoSozpq0/XdidHwtxfAF6C93SkszaF5
         yz6vXGgaSovwY8rUC8ixGTZ78GaFjxEacbGcsxYvrJf7JIb7T6CrMUagpIdJxtUGmCeG
         yYW+qTks+9DBnr7lnYYxqaxFtj/FHLFsi3F0Y1S5/0P1qqb0NPX5xqZE/9V0IQVRpvoa
         MeOg==
X-Gm-Message-State: AOJu0YzQhs9EqHmmQrDSrWJ2EQrqd+QaajLyROuYxPtexEL8tdc6ayzx
	6xBfsSv2XBuDOX+xe/lhsI9ntpi0S00nE0lBM/UvFf0jOgC7pe8+9nFRKY5/Q6Q=
X-Google-Smtp-Source: AGHT+IEeERlZ3NqH9PZIv/iNmFvZe2UYPQvB7v+bg0RpFLaZzb2oP7L8VfnGGRpFzLwST/0D0QEoTA==
X-Received: by 2002:a2e:9cc9:0:b0:2ef:259f:a569 with SMTP id 38308e7fff4ca-2f15aa872a4mr1311041fa.15.1722517024291;
        Thu, 01 Aug 2024 05:57:04 -0700 (PDT)
Received: from localhost (78-80-9-176.customers.tmcz.cz. [78.80.9.176])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590cedsm10082854a12.29.2024.08.01.05.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 05:57:03 -0700 (PDT)
Date: Thu, 1 Aug 2024 14:57:02 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 00/12] net: introduce TX H/W shaping API
Message-ID: <ZquGHlbdBvFbhPpg@nanopsycho.orion>
References: <cover.1722357745.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722357745.git.pabeni@redhat.com>

Tue, Jul 30, 2024 at 10:39:43PM CEST, pabeni@redhat.com wrote:
>We have a plurality of shaping-related drivers API, but none flexible
>enough to meet existing demand from vendors[1].
>
>This series introduces new device APIs to configure in a flexible way
>TX H/W shaping. The new functionalities are exposed via a newly
>defined generic netlink interface and include introspection
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


I got here and got lost :) What's "input" and "output" meaning here?

In general, I'm missing some documentation file to describe the design
of the shapers. I lookes at the patch descriptions and comments, could
not figure it out :/ Could you please draft it?



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
>deleting the last shaper under a group deletes the group, too:
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
>Changes from RFC v2:
> - added patch 1
> - fixed deprecated API usage
>
>RFC v2: https://lore.kernel.org/netdev/cover.1721851988.git.pabeni@redhat.com/
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
>Paolo Abeni (8):
>  tools: ynl: lift an assumption about spec file name
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
> net/shaper/shaper.c                           | 963 ++++++++++++++++++
> net/shaper/shaper_nl_gen.c                    | 142 +++
> net/shaper/shaper_nl_gen.h                    |  30 +
> tools/net/ynl/ynl-gen-c.py                    |   6 +-
> tools/testing/selftests/drivers/net/Makefile  |   1 +
> tools/testing/selftests/drivers/net/shaper.py | 267 +++++
> .../testing/selftests/net/lib/py/__init__.py  |   1 +
> tools/testing/selftests/net/lib/py/ynl.py     |   5 +
> 37 files changed, 2988 insertions(+), 4 deletions(-)
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

