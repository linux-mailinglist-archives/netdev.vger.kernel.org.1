Return-Path: <netdev+bounces-55400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B815B80AC10
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D03D2818EA
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 18:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFCE33090;
	Fri,  8 Dec 2023 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEN5VCF8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D570DA3
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 10:30:12 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d0c93b1173so18489895ad.2
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 10:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702060212; x=1702665012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uudr65KCGtkUzlRZuU01tlegxkyhUua9QWYMjQtjy2g=;
        b=TEN5VCF8Cw5rnhM5j0DcG6YzqUGFYRw8oAaKl27CC7LCHkgzKUCWHV2SN5wOEC5bZb
         k3UfwAxJTHu9UzGaZGk26OEiCq8jxQy8LdWAc25Eg6iOVvwv34csk9H86MVgy1g72qcn
         Jsc6ji5Vnm+yzpepg5j7vIfP887fdyHcDZKtg5XmyEt47hicOGq4PF0/QtvJPOjeRn0F
         TLrLywyrPo5g31A5puV1v36lN0ehQUfMagSINiVdIC1LScVXgYNnqf7Ci2fsDP8zT7El
         uY7697zm24XNp+/kCFPq2CnqMlYqHLO/zvd/K/TEGMQj5lniaxqQGcv6jAb3rAQLbYW0
         AaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702060212; x=1702665012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uudr65KCGtkUzlRZuU01tlegxkyhUua9QWYMjQtjy2g=;
        b=nZWrzzf5TIiKQVtsM99wBh6D2JCdUu+v4ycCiP8skYp6X0YAdZOvgEDx7sIssYDaO/
         Uu4niCGhIL2377FvVlRYg8ZlIr2/wW+/kctUWBWmFYSeFqwOQswHx93ESA5ggDJoxiqt
         9pAUMkQLWATaIOJb3FuvPD+097YXPxu50vuIQ0djHeWzorClLSJcBQ6EMQQuNfRbFXS4
         j9ty+xnygZ3qtH5gi3I+5XtvEIJNW+OrgFUwa1zCSjuIjrWV8O58X1KGdwVexjtFXoQX
         hYFTBxFaiP7Iy2ee1ReJ3t83yAf7L5673imGGwF7ewfGzFKtotqmkAOMtjl2KtGiBLMx
         P+Cw==
X-Gm-Message-State: AOJu0YyZIbtn4daHrFwh5zTVgX7DNWR0dTR2/ACuj1djZymIpFQWYbjz
	CC5L6qsMMiAev4UFq/vLj0E=
X-Google-Smtp-Source: AGHT+IFSryZ38+9cBxya3IT9T9P4JUM/39pjvbHAVYLB1t4J7uZxoJrIXP5+sJrzl96OZkC7EnScTg==
X-Received: by 2002:a17:902:6b07:b0:1d2:eb13:5cd5 with SMTP id o7-20020a1709026b0700b001d2eb135cd5mr420075plk.42.1702060212244;
        Fri, 08 Dec 2023 10:30:12 -0800 (PST)
Received: from swarup-virtual-machine ([171.76.80.2])
        by smtp.gmail.com with ESMTPSA id ix9-20020a170902f80900b001d07554254esm2021457plb.160.2023.12.08.10.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 10:30:11 -0800 (PST)
Date: Sat, 9 Dec 2023 00:00:05 +0530
From: swarup <swarupkotikalapudi@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH net-next v5] netlink: specs: devlink: add some(not all)
 missing attributes in devlink.yaml
Message-ID: <ZXNgrTDRd+nFa1Ad@swarup-virtual-machine>
References: <20231202123048.1059412-1-swarupkotikalapudi@gmail.com>
 <20231205191944.6738deb7@kernel.org>
 <ZXAoGhUnBFzQxD0f@nanopsycho>
 <20231206080611.4ba32142@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206080611.4ba32142@kernel.org>

On Wed, Dec 06, 2023 at 08:06:11AM -0800, Jakub Kicinski wrote:
> On Wed, 6 Dec 2023 08:51:54 +0100 Jiri Pirko wrote:
> > My "suggested-by" is probably fine as I suggested Swarup to make the patch :)
> 
> Ah, I didn't realize, sorry :) Just mine needs to go then.

Hi Jiri,

Please find answer for some quesion from you.

1. I removed the Fixes tag.

2. I removed Jakub's name from Suggested-by tag.

3. I added new line as suggested.

   value: ## or number, is used only if there is a gap or
   missing attribute just above of any attribute which is not yet filled.    

4. dl-attr-stats has a value 0 as shown below for this reason:
    name: dl-attr-stats
    name-prefix: devlink-attr-
    attributes:
      - name: stats-rx-packets
        type: u64
        value: 0 <-- 0 is added here due to below mentioned reason
                     but mainly to match order of stats unnamed enum declared in include/uapi/linux/devlink.h
      -
        name: stats-rx-bytes
        type: u64
      -
        name: stats-rx-dropped
        type: u64

-------------- different command to get ttl_value_is_too_small with trap command -----------
   #~/devlink_work/net-next$ sudo devlink -jpnsv trap show netdevsim/netdevsim1 trap ttl_value_is_too_small
   {
      "trap": {
        "netdevsim/netdevsim1": [ {
                "name": "ttl_value_is_too_small",
                "type": "exception",
                "generic": true,
                "action": "trap",
                "group": "l3_exceptions",
                "metadata": [ "input_port" ],
                "stats": {
                    "rx": {
                        "bytes": 341019532,
                        "packets": 2401546,
                        "dropped": 48
                    }
                }
            } ]
      }
   }
----------

..... another command to get ttl_value_is_too_small trap command ---------
:~/devlink_work/net-next$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml --do trap-get --json '{"bus-name": "netdevsim", "dev-name": "netdevsim1", "trap-name": "ttl_value_is_too_small"}' --process-unknown
{'bus-name': 'netdevsim',
 'dev-name': 'netdevsim1',
 'stats': {'stats-rx-bytes': 341152018,
           'stats-rx-dropped': 49,
           'stats-rx-packets': 2402479},
 'trap-action': 'trap',
 'trap-generic': True,
 'trap-group-name': 'l3_exceptions',
 'trap-metadata': {'trap-metadata-type-in-port': True},
 'trap-name': 'ttl_value_is_too_small',
 'trap-type': 'exception'}
------------

2nd command returned stats values matches with 1st command returned stats value, when "dl-attr-stats" value is zero.

trap.c function which fills stats value fills as mentioned below:
static int devlink_trap_stats_put(struct sk_buff *msg, struct devlink *devlink,
                                  const struct devlink_trap_item *trap_item)
{
        struct devlink_stats stats;
        ...... <-- code omitted
        if (devlink->ops->trap_drop_counter_get &&
            nla_put_u64_64bit(msg, DEVLINK_ATTR_STATS_RX_DROPPED, drops,
                              DEVLINK_ATTR_PAD))
                goto nla_put_failure;

        if (nla_put_u64_64bit(msg, DEVLINK_ATTR_STATS_RX_PACKETS,
                              u64_stats_read(&stats.rx_packets),
                              DEVLINK_ATTR_PAD))
                goto nla_put_failure;

        if (nla_put_u64_64bit(msg, DEVLINK_ATTR_STATS_RX_BYTES,
                              u64_stats_read(&stats.rx_bytes),
                              DEVLINK_ATTR_PAD))
                goto nla_put_failure;

        .... <-- code omitted
        return 0;

nla_put_failure:
        nla_nest_cancel(msg, attr);
        return -EMSGSIZE;
}

but in --> include/uapi/linux/devlink.h
stats is declared as mentioned below:
enum {
        DEVLINK_ATTR_STATS_RX_PACKETS,          /* u64 */
        DEVLINK_ATTR_STATS_RX_BYTES,            /* u64 */
        DEVLINK_ATTR_STATS_RX_DROPPED,          /* u64 */

        __DEVLINK_ATTR_STATS_MAX,
        DEVLINK_ATTR_STATS_MAX = __DEVLINK_ATTR_STATS_MAX - 1
};

Hence to keep the order mentioned in enum, i assigned value of 0,
so that rx_packets, rx_btes and rx_dropped picks correct values.



