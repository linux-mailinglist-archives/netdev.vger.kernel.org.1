Return-Path: <netdev+bounces-207646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E48B0810C
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 01:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DFBA7A127C
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 23:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351132ECD38;
	Wed, 16 Jul 2025 23:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="b2QRGDCi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gbYwxrXf"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E041581EE;
	Wed, 16 Jul 2025 23:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752708828; cv=none; b=oqAhlSYhzFdTlO9FcSLs8V1uRFbIlIEnirTZxWCl47CB2KOiXpPlqraOOOvF2SeBvlmqAtq6YOwCe2WfzFUJMoK9Ck//7yNfIdOVUEAIi968EqJko8+Jn3YJjVrklzNInpgBT9XxrU8xjh4/S5muj1tuGRrER0J9XkEqTAWOIws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752708828; c=relaxed/simple;
	bh=LzqftZdc4+mnHHm+k8nhqy8oG4SZDOFg/v3x5bWpL3c=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=dUM3K6AVSG5868uusrNxef1GmKHzjDatvsY8KCKYNrdjHf7jLcnT3MUBK75ClH2zoN5KL9Be1amvoMVI/EE2p/hIuG2w4zFQmc3etGTPOrYskJurU7AS/lKG5nw6OnsEoWE7yI42WrLdUjq8O/b6Hp+64lj258kH/IHuTQgYOMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=b2QRGDCi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gbYwxrXf; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B6E10EC01D1;
	Wed, 16 Jul 2025 19:33:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 16 Jul 2025 19:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1752708822; x=1752795222; bh=9neY7JnORRQ6tCfHWMu9ZGbiJTIktxJS
	p0grs8cTTAQ=; b=b2QRGDCiBZITVzwX+kvrTX+dmEz2upIVPeCNmusIVP2b1OX0
	bGb8uNAV46iDL5DhYWKcj7LlPPqQ0QsE9s419EjiqacllYQx5q2bfhvLmQgUa/9n
	uEDvUAmX0k//81EznBoncAPTMhZ0yK4agVHg3DNHQD9nyF3TjDWs2913QY43IDbk
	d/TJeqS2fan/pB7BLjpZVkp7dtPkzXdBRzBeV30Cb9LZ6bwXUYREmTB0N1azamjz
	poNOnpzY3tyg1vD/dNTXvmD1g12O5vkn8jgyALrVC8DZnmUKNW+dkKUWaiu/GWsy
	EMl/27KRpg3j6bGl5H21Lz0lfNcygbk2b15dKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752708822; x=
	1752795222; bh=9neY7JnORRQ6tCfHWMu9ZGbiJTIktxJSp0grs8cTTAQ=; b=g
	bYwxrXfTssPriEQ9f6q8qkKxy4LL4eSCmToonK3zKNLSD6CsDSwGHxFGLRhpWS9D
	Sz3lMtIoo/ys89YZdVYvVrao8TSSMmBo4CwotdS+c9Evy2yPRqoH35Dg3PlxWldi
	bB8KRp+vV0kKPpeusfu4ZGW4Q1ra+09hqo3ANmJCuRAN55aHOTDk43pedf7g+cxI
	NuLEET5rdi0RoNqESXjhWHXPzF10UPzwuRIHPaVc5UnHZC122GYMJ89kkPOUeJtG
	59G5phf9xoL0uJKALpIW4J+zv+02ezQ3n2MW0vbUbLN0oybA/JuWYgswhJHN+6bO
	+OYyJanLdDuyUPC/ka9yQ==
X-ME-Sender: <xms:1jZ4aGopxSiZPYaDidy8MKYfaBjBAMdilVe07g72hc8Fvk76AvmoWg>
    <xme:1jZ4aKJ0at_3IqEnqv3AQ-lu3z-UL4CP8J9-jNHRoG_xsDLirEKrsBUY0dzNlJzKc
    Leyxsa_Ey7I_nJytf4>
X-ME-Received: <xmr:1jZ4aKQGdPExpmyOZUt8RCyD3B5ooB4cALRRCqEvMUSnLVEdqVKD9adwuatea-Euw1yFxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehledtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhfogggtgfffkfesthhqredtredtjeenucfhrhhomheplfgrhicuggho
    shgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvghtqeenucggtffrrghtthgvrh
    hnpeegfefghffghffhjefgveekhfeukeevffethffgtddutdefffeuheelgeelieeuhfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjh
    hvohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpth
    htoheptggrrhhlohhsrdgsihhlsggrohdrohhsuggvvhesghhmrghilhdrtghomhdprhgt
    phhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoheptggrrh
    hlohhsrdgsihhlsggroheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhorhhmshes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehsfhhorhhshhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghn
    ughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehprggsvghnihesrh
    gvughhrghtrdgtohhm
X-ME-Proxy: <xmx:1jZ4aKM5Jy0yckMlWhFZP4wIRh2utaH26bFW5Y2qJ3Wu7b-ElZR1aw>
    <xmx:1jZ4aPV6Kkbe9_sqcW0dn5xxhSuGZYfEnH5cPdMBUf09sVEQUfK1mA>
    <xmx:1jZ4aNiZWlduVzWRb2u0g5trn4-D_D6zOGlF-NT1v_RQ48q4Oc51cw>
    <xmx:1jZ4aIgwWSCuDSXIsWz2Z5qDvOmKZ1r1ASQquzk2Ypz9HDgcz5kWMA>
    <xmx:1jZ4aDzpK1fP3qvZCB8zdXB_Umc-6rhIFcxfrY2KQCC9QYfReQ2QkCE->
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 19:33:41 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 491AB9FC97; Wed, 16 Jul 2025 16:33:40 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 4821F9FB65;
	Wed, 16 Jul 2025 16:33:40 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
cc: Carlos Bilbao <bilbao@vt.edu>, carlos.bilbao@kernel.org,
    andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
    sforshee@kernel.org
Subject: Re: [PATCH] bonding: Switch periodic LACPDU state machine from counter to jiffies
In-reply-to: <c1cf6883-a323-40e8-881d-ae7023bbc61a@gmail.com>
References: <20250715205733.50911-1-carlos.bilbao@kernel.org> <c9eac8f6-8e7f-4ed0-b34d-5dc50be8078f@vt.edu> <798952.1752679803@famine> <c1cf6883-a323-40e8-881d-ae7023bbc61a@gmail.com>
Comments: In-reply-to Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
   message dated "Wed, 16 Jul 2025 14:44:04 -0500."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Jul 2025 16:33:40 -0700
Message-ID: <826702.1752708820@famine>

Carlos Bilbao <carlos.bilbao.osdev@gmail.com> wrote:

>Hello Jay,
>
>On 7/16/25 10:30, Jay Vosburgh wrote:
>> Carlos Bilbao <bilbao@vt.edu> wrote:
>>
>>> FYI, I was able to test this locally but couldn=E2=80=99t find any ksel=
ftests to
>>> stress the bonding state machine. If anyone knows of additional ways to
>>> test it, I=E2=80=99d be happy to run them.
>> 	Your commit message says this change will "help reduce drift
>> under contention," but above you say you're unable to stress the state
>> machine.
>>
>> 	How do you induce "drift under contention" to test that your
>> patch actually improves something?  What testing has been done to insure
>> that the new code doesn't change the behavior in other ways (regressions=
)?
>
>
>I tested the bonding driver with and without CPU contention*. With this
>patch, the LACPDU state machine is much more consistent under load, with
>standard deviation of 0.0065 secs between packets. In comparison, the
>current version had a standard deviation of 0.15 secs (~x23 more
>variability). I imagine this gets worsens with greater contention.

	You're measuring the time between successive LACPDU
transmissions?  So, "perfect" is exactly 1 second between successive
LACPDUs?

	Assuming that's the case, then the results seem odd to me,
perhaps I'm not understanding something, or maybe the standard deviation
isn't the right representation here.=20=20

	If the drift under stress is due to scheduling delays of the
workqueue event that runs bond_3ad_state_machine_handler (which in turn
will call the periodic state machine function, ad_periodic_machine),
then I'd expect to see the inter-LACPDU time vary according to that
scheduling delay.

	For the existing implementation, because it's counter based, the
delays would simply add up, and the expiration of the periodic_timer
(per Figure 6-19 in 802.1AX-2014, the transition from FAST_PERIODIC to
PERIODIC_TX) would be delayed by whatever the sum of the delays is.

	As a hypothetical, the workqueue event normally runs every
100ms.  Suppose the next expiration is set to 10 workqueue events from
now, so one second.  Further suppose that the workqueue event runs 5 ms
late, so 105 ms.  After 10 executions, it will be at 1050 ms from the
start time, and the periodic_timer would expire 50 ms late.

	For the jiffies based implementation proposed here, I'd expect
the same behavior up to a point, due to the granularity of the workqueue
event at 100ms.

	Doing the same hypothetical, the workqueue event normally runs
every 100ms, and the next periodic_timer expiration is set to now + 1
second, in jiffies.  If the workqueue event runs 5 ms late again, after
9 executions, it will be at 945 ms from the start time, so it won't
expire the timer.  The next execution would be at 1050 ms, and the timer
would then expire, but it's still 50 ms late.

	So, in your tests, do we know what the actual scheduling delays
are, as well as the distribution of the times you've measured?

	I'm willing to believe that your proposal may be better, but I'm
not understanding why from the data you've shared (0.0065 vs 0.15).

	-J

>When I mentioned a possible kselftest (or similar) to "stress" the state
>machine, I meant whether there's already any testing that checks the
>state machine through different transitions -- e.g., scenarios where the
>switch instruct the bond to change configs (for example, between fast and
>slow LACP modes), resetting the bond under certain conditions, etc. I just
>want to be exhaustive because as you mentioned the state machine has been
>around for long time.
>
>*System was stressed using:
>
>stress-ng --cpu $(nproc) --timeout 60
>
>Metrics were collected with:
>
>sudo tcpdump -e -ni <my interface> ether proto 0x8809 and ether src <mac>
>
>
>>
>> 	Without a specific reproducable bug scenario that this change
>> fixes, I'm leery of applying such a refactor to code that has seemingly
>> been working fine for 20+ years.
>>
>> 	I gather that what this is intending to do is reduce the current
>> dependency on the scheduling accuracy of the workqueue event that runs
>> the state machines.  The current implementation works on a "number of
>> invocations" basis, assuming that the event is invoked every 100 msec,
>> and computes various timeouts based on the number of times the state
>
>
>Yep.
>
>
>> machine runs.
>>
>> 	-J
>>
>>> Thanks!
>>>
>>> Carlos
>>>
>>> On 7/15/25 15:57, carlos.bilbao@kernel.org wrote:
>>>> From: Carlos Bilbao <carlos.bilbao@kernel.org>
>>>>
>>>> Replace the bonding periodic state machine for LACPDU transmission of
>>>> function ad_periodic_machine() with a jiffies-based mechanism, which is
>>>> more accurate and can help reduce drift under contention.
>>>>
>>>> Signed-off-by: Carlos Bilbao (DigitalOcean) <carlos.bilbao@kernel.org>
>>>> ---
>>>>    drivers/net/bonding/bond_3ad.c | 79 +++++++++++++------------------=
---
>>>>    include/net/bond_3ad.h         |  2 +-
>>>>    2 files changed, 32 insertions(+), 49 deletions(-)
>>>>
>>>> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond=
_3ad.c
>>>> index c6807e473ab7..8654a51266a3 100644
>>>> --- a/drivers/net/bonding/bond_3ad.c
>>>> +++ b/drivers/net/bonding/bond_3ad.c
>>>> @@ -1421,44 +1421,24 @@ static void ad_periodic_machine(struct port *p=
ort, struct bond_params *bond_para
>>>>    	    (!(port->actor_oper_port_state & LACP_STATE_LACP_ACTIVITY) && =
!(port->partner_oper.port_state & LACP_STATE_LACP_ACTIVITY)) ||
>>>>    	    !bond_params->lacp_active) {
>>>>    		port->sm_periodic_state =3D AD_NO_PERIODIC;
>>>> -	}
>>>> -	/* check if state machine should change state */
>>>> -	else if (port->sm_periodic_timer_counter) {
>>>> -		/* check if periodic state machine expired */
>>>> -		if (!(--port->sm_periodic_timer_counter)) {
>>>> -			/* if expired then do tx */
>>>> -			port->sm_periodic_state =3D AD_PERIODIC_TX;
>>>> -		} else {
>>>> -			/* If not expired, check if there is some new timeout
>>>> -			 * parameter from the partner state
>>>> -			 */
>>>> -			switch (port->sm_periodic_state) {
>>>> -			case AD_FAST_PERIODIC:
>>>> -				if (!(port->partner_oper.port_state
>>>> -				      & LACP_STATE_LACP_TIMEOUT))
>>>> -					port->sm_periodic_state =3D AD_SLOW_PERIODIC;
>>>> -				break;
>>>> -			case AD_SLOW_PERIODIC:
>>>> -				if ((port->partner_oper.port_state & LACP_STATE_LACP_TIMEOUT)) {
>>>> -					port->sm_periodic_timer_counter =3D 0;
>>>> -					port->sm_periodic_state =3D AD_PERIODIC_TX;
>>>> -				}
>>>> -				break;
>>>> -			default:
>>>> -				break;
>>>> -			}
>>>> -		}
>>>> +	} else if (port->sm_periodic_state =3D=3D AD_NO_PERIODIC)
>>>> +		port->sm_periodic_state =3D AD_FAST_PERIODIC;
>>>> +	/* check if periodic state machine expired */
>>>> +	else if (time_after_eq(jiffies, port->sm_periodic_next_jiffies)) {
>>>> +		/* if expired then do tx */
>>>> +		port->sm_periodic_state =3D AD_PERIODIC_TX;
>>>>    	} else {
>>>> +		/* If not expired, check if there is some new timeout
>>>> +		 * parameter from the partner state
>>>> +		 */
>>>>    		switch (port->sm_periodic_state) {
>>>> -		case AD_NO_PERIODIC:
>>>> -			port->sm_periodic_state =3D AD_FAST_PERIODIC;
>>>> -			break;
>>>> -		case AD_PERIODIC_TX:
>>>> -			if (!(port->partner_oper.port_state &
>>>> -			    LACP_STATE_LACP_TIMEOUT))
>>>> +		case AD_FAST_PERIODIC:
>>>> +			if (!(port->partner_oper.port_state & LACP_STATE_LACP_TIMEOUT))
>>>>    				port->sm_periodic_state =3D AD_SLOW_PERIODIC;
>>>> -			else
>>>> -				port->sm_periodic_state =3D AD_FAST_PERIODIC;
>>>> +			break;
>>>> +		case AD_SLOW_PERIODIC:
>>>> +			if ((port->partner_oper.port_state & LACP_STATE_LACP_TIMEOUT))
>>>> +				port->sm_periodic_state =3D AD_PERIODIC_TX;
>>>>    			break;
>>>>    		default:
>>>>    			break;
>>>> @@ -1471,21 +1451,24 @@ static void ad_periodic_machine(struct port *p=
ort, struct bond_params *bond_para
>>>>    			  "Periodic Machine: Port=3D%d, Last State=3D%d, Curr State=3D%d=
\n",
>>>>    			  port->actor_port_number, last_state,
>>>>    			  port->sm_periodic_state);
>>>> +
>>>>    		switch (port->sm_periodic_state) {
>>>> -		case AD_NO_PERIODIC:
>>>> -			port->sm_periodic_timer_counter =3D 0;
>>>> -			break;
>>>> -		case AD_FAST_PERIODIC:
>>>> -			/* decrement 1 tick we lost in the PERIODIC_TX cycle */
>>>> -			port->sm_periodic_timer_counter =3D __ad_timer_to_ticks(AD_PERIODI=
C_TIMER, (u16)(AD_FAST_PERIODIC_TIME))-1;
>>>> -			break;
>>>> -		case AD_SLOW_PERIODIC:
>>>> -			/* decrement 1 tick we lost in the PERIODIC_TX cycle */
>>>> -			port->sm_periodic_timer_counter =3D __ad_timer_to_ticks(AD_PERIODI=
C_TIMER, (u16)(AD_SLOW_PERIODIC_TIME))-1;
>>>> -			break;
>>>>    		case AD_PERIODIC_TX:
>>>>    			port->ntt =3D true;
>>>> -			break;
>>>> +			if (!(port->partner_oper.port_state &
>>>> +						LACP_STATE_LACP_TIMEOUT))
>>>> +				port->sm_periodic_state =3D AD_SLOW_PERIODIC;
>>>> +			else
>>>> +				port->sm_periodic_state =3D AD_FAST_PERIODIC;
>>>> +		fallthrough;
>>>> +		case AD_SLOW_PERIODIC:
>>>> +		case AD_FAST_PERIODIC:
>>>> +			if (port->sm_periodic_state =3D=3D AD_SLOW_PERIODIC)
>>>> +				port->sm_periodic_next_jiffies =3D jiffies
>>>> +					+ HZ * AD_SLOW_PERIODIC_TIME;
>>>> +			else /* AD_FAST_PERIODIC */
>>>> +				port->sm_periodic_next_jiffies =3D jiffies
>>>> +					+ HZ * AD_FAST_PERIODIC_TIME;
>>>>    		default:
>>>>    			break;
>>>>    		}
>>>> @@ -1987,7 +1970,7 @@ static void ad_initialize_port(struct port *port=
, int lacp_fast)
>>>>    		port->sm_rx_state =3D 0;
>>>>    		port->sm_rx_timer_counter =3D 0;
>>>>    		port->sm_periodic_state =3D 0;
>>>> -		port->sm_periodic_timer_counter =3D 0;
>>>> +		port->sm_periodic_next_jiffies =3D 0;
>>>>    		port->sm_mux_state =3D 0;
>>>>    		port->sm_mux_timer_counter =3D 0;
>>>>    		port->sm_tx_state =3D 0;
>>>> diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
>>>> index 2053cd8e788a..aabb8c97caf4 100644
>>>> --- a/include/net/bond_3ad.h
>>>> +++ b/include/net/bond_3ad.h
>>>> @@ -227,7 +227,7 @@ typedef struct port {
>>>>    	rx_states_t sm_rx_state;	/* state machine rx state */
>>>>    	u16 sm_rx_timer_counter;	/* state machine rx timer counter */
>>>>    	periodic_states_t sm_periodic_state;	/* state machine periodic sta=
te */
>>>> -	u16 sm_periodic_timer_counter;	/* state machine periodic timer count=
er */
>>>> +	unsigned long sm_periodic_next_jiffies;	/* state machine periodic ne=
xt expected sent */
>>>>    	mux_states_t sm_mux_state;	/* state machine mux state */
>>>>    	u16 sm_mux_timer_counter;	/* state machine mux timer counter */
>>>>    	tx_states_t sm_tx_state;	/* state machine tx state */
>> ---
>> 	-Jay Vosburgh, jv@jvosburgh.net
>>
>
>Thanks,
>
>Carlos
>

---
	-Jay Vosburgh, jv@jvosburgh.net

