Return-Path: <netdev+bounces-19879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E1975CA4C
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D906E281F1C
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 14:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1F627F12;
	Fri, 21 Jul 2023 14:42:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5BF27F05
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 14:42:55 +0000 (UTC)
Received: from out-63.mta0.migadu.com (out-63.mta0.migadu.com [91.218.175.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063C335BB
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 07:42:49 -0700 (PDT)
Message-ID: <dbbfd954-efef-67e6-b291-539c0b0b5ac4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1689950567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mg2SzEE2M9WvVRfM1Guy+LNUuC3B+BHA9FYVw72Vv+0=;
	b=IbkDFl+0eJMk/qy7B7jfVxr03KcCAlklrh/Ou8ViMvTUdWjThyX9CmdtZ36mhDRtERb/nv
	CBwMVHKk/pXH52lxDNshhaXG3OFNzLTiztm1HoHCW9gZ4xyby9Vuq5c51p9VE9JzHPsrgx
	u+aTLC4vCZ3Q4qnsPmaPoZTM7DGkNqY=
Date: Fri, 21 Jul 2023 15:42:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 00/11] Create common DPLL configuration API
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Milena Olech <milena.olech@intel.com>,
 Michal Michalik <michal.michalik@intel.com>,
 linux-arm-kernel@lists.infradead.org, poros@redhat.com, mschmidt@redhat.com,
 netdev@vger.kernel.org, linux-clk@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <ZLpom60B+fkjsoG1@nanopsycho>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <ZLpom60B+fkjsoG1@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 21.07.2023 12:14, Jiri Pirko wrote:
> There are couple of issues that came up during our internal ci run:
> 
> 10:16:04  error: drivers/dpll/dpll_netlink.c:452:5: error: no previous prototype for '__dpll_device_change_ntf' [-Werror=missing-prototypes]
> 10:16:04  error: drivers/dpll/dpll_netlink.c:1283:13: error: no previous prototype for 'dpll_netlink_fini' [-Werror=missing-prototypes]
> 10:16:04  error: drivers/dpll/dpll_core.c:221:1: error: no previous prototype for 'dpll_xa_ref_dpll_find' [-Werror=missing-prototypes]
> 
> 10:27:31  error: drivers/dpll/dpll_core.c:220:21: warning: symbol 'dpll_xa_ref_dpll_find' was not declared. Should it be static?
> 10:27:31  error: drivers/dpll/dpll_netlink.c:452:5: warning: symbol '__dpll_device_change_ntf' was not declared. Should it be static?
> 10:27:31  error: drivers/dpll/dpll_netlink.c:1283:13: warning: symbol 'dpll_netlink_fini' was not declared. Should it be static?
> 10:27:41  error: drivers/net/ethernet/intel/ice/ice_dpll.c:461:3: error: a label can only be part of a statement and a declaration is not a statement
> 
> I believe that you didn't run make with C=2, otherwise you would hit
> these.

Yeah, I'll re-run the set patch-by-patch with C=2 next time.

> 
> Checkpatch issue:
> 10:29:30  CHECK: struct mutex definition without comment
> 10:29:30  #6581: FILE: drivers/net/ethernet/intel/ice/ice_dpll.h:85:
> 10:29:30  +	struct mutex lock;

Arkadiusz will take care of "ice" part.


> Spelling errors:
> 10:45:08  error: Documentation/netlink/specs/dpll.yaml:165: prority ==> priority
> 10:45:08  error: include/uapi/linux/dpll.h:128: prority ==> priority
> 10:45:08  error: drivers/net/ethernet/intel/ice/ice_dpll.c:2008: userpsace ==> userspace
> 10:45:08  error: drivers/net/ethernet/intel/ice/ice_dpll.h:20: properities ==> properties
> 

Will fix it.

> 
> Thu, Jul 20, 2023 at 11:18:52AM CEST, vadim.fedorenko@linux.dev wrote:
>> Implement common API for clock/DPLL configuration and status reporting.
>> The API utilises netlink interface as transport for commands and event
>> notifications. This API aim to extend current pin configuration and
> 
> s/API aim/API aims/
> 
> 
>> make it flexible and easy to cover special configurations.
> 
> I don't follow. How this could "aim to extend current pin configuration" ?
> This is a new thing. Could you re-phrase?

Not really new. PTP devices have already simple pin configurations, mlx5 is 
using it for some cards with external pins. The problem is that PTP subsystem
covers only simple configuration of the pin and doesn't cover DPLL part at all.

> 
> What's "special configuration"? Sounds odd.
> 

Yeah, "complex configurations" sounds better, will change it.

> 
>>
>> Netlink interface is based on ynl spec, it allows use of in-kernel
>> tools/net/ynl/cli.py application to control the interface with properly
>> formated command and json attribute strings. Here are few command
>> examples of how it works with `ice` driver on supported NIC:
>>
>> - dump dpll devices
>> $# ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
> 
> "$#" looks a bit odd. Just "$" with "sudo" when you want to emphasize
> root is needed to perform the command.
> 
> 
>> --dump device-get
>> [{'clock-id': 282574471561216,
>>   'id': 0,
>>   'lock-status': 'unlocked',
>>   'mode': 'automatic',
>>   'module-name': 'ice',
>>   'type': 'eec'},
>> {'clock-id': 282574471561216,
>>   'id': 1,
>>   'lock-status': 'unlocked',
>>   'mode': 'automatic',
>>   'module-name': 'ice',
>>   'type': 'pps'}]
>>
>> - get single pin info:
>> $# ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
>> --do pin-get --json '{"pin-id":2}'
>> {'clock-id': 282574471561216,
>> 'module-name': 'ice',
>> 'pin-board-label': 'C827_0-RCLKA',
>> 'pin-dpll-caps': 6,
>> 'pin-frequency': 1953125,
>> 'pin-id': 2,
>> 'pin-parenti-device': [{'id': 0,
> 
> This looks like manual edit went wrong :)
> s/parenti/parent/
> 

Ahhh... yeah :)

> 
>>                          'pin-direction': 'input',
>>                          'pin-prio': 11,
>>                          'pin-state': 'selectable'},
>>                         {'id': 1,
>>                          'pin-direction': 'input',
>>                          'pin-prio': 9,
>>                          'pin-state': 'selectable'}],
>> 'pin-type': 'mux'}
>>
>> - set pin's state on dpll:
>> $# ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
>> --do pin-set --json '{"pin-id":2, "pin-parent-device":{"id":1, "pin-state":2}}'
>>
>> - set pin's prio on dpll:
>> $# ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
>> --do pin-set --json '{"pin-id":2, "pin-parent-device":{"id":1, "pin-prio":4}}'
>>
>> - set pin's state on parent pin:
>> $# ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
>> --do pin-set --json '{"pin-id":13, \
>>                       "pin-parent-pin":{"pin-id":2, "pin-state":1}}'
>>
> 
> [...]


