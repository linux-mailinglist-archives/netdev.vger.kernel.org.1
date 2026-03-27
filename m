Return-Path: <netdev+bounces-272613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNADKtWqxmk4NQUAu9opvQ
	(envelope-from <netdev+bounces-272613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 17:05:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 300AD347208
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 17:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6F973070B70
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E594533F5A0;
	Fri, 27 Mar 2026 16:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vWeuxsZW"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5755830E821
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627405; cv=none; b=XijA+JmoqVo8rWR8so+507k4/wCrDpZQ1EaSwuobIvS2IX4SH0eRetdCK+nkT3W/mnGIpbscZFVoydq9S77u0rLKT1viKzpBkNUfssNR5DrUy1w2e1rmxujxIpHXpAvzpP7F0efkcZCm9v1ONZQqRo/SRx/LVy9zseLp34Q5fIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627405; c=relaxed/simple;
	bh=+wSY40mmdULyCUx/FsYtjicfNL332WyWQV2m45z04D4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=sClSLu4i7qOig6HHyTNM2zzYPY0743pihAIdDCusBnIIyzYQguR6W98bawHlUJiImtxxrkfRHiZ7Xm8x592vDZNcttCo5YZ1JC3QzWclxPIUxVoYYZMy5fu3gKPpiIGHQwg8795fu2lQ4dnVCMg5mzW9a6IrW3hgYVwCVI/rcJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vWeuxsZW; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 27 Mar 2026 17:03:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774627400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZV7OuN5i/AUQCT2vgdiJixmKiWOC9p1GUtqFLOSlAyw=;
	b=vWeuxsZWX13VnojlEpP1pKC4tgABC8HstC7cXtYGk4bT0TcNl0a8qD0DgxY7yS83spErWG
	pMjJb02uuTFWpM4wVIuj2Pxx5M0cmLPplV1Bv9nA1E1oei1DlDEzqGf9N60M4Vxh78/qqm
	tlKonp3EGLXr5rLqQGZPMwqPKTU3Y4I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luka Gejak <luka.gejak@linux.dev>
To: Felix Maurer <fmaurer@redhat.com>
CC: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, liuhangbin@gmail.com,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_v2_2/4=5D_net=3A_hsr?=
 =?US-ASCII?Q?=3A_fix_VLAN_add_unwind_on_slave_errors?=
In-Reply-To: <acZvYp_SYvypHWgk@thinkpad>
References: <20260326154715.38405-1-luka.gejak@linux.dev> <20260326154715.38405-3-luka.gejak@linux.dev> <acZvYp_SYvypHWgk@thinkpad>
Message-ID: <F40ED495-9115-489C-A010-0011A9229C4A@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-272613-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 300AD347208
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On March 27, 2026 12:52:02 PM GMT+01:00, Felix Maurer <fmaurer@redhat=2Ecom=
> wrote:
>Thank you for updating this patch!
>
>On Thu, Mar 26, 2026 at 04:47:13PM +0100, luka=2Egejak@linux=2Edev wrote:
>> From: Luka Gejak <luka=2Egejak@linux=2Edev>
>>
>> When vlan_vid_add() fails for a secondary slave, the error path calls
>> vlan_vid_del() on the failing port instead of the peer slave that had
>> already succeeded=2E This results in asymmetric VLAN state across the H=
SR
>> pair=2E
>>
>> Fix this by switching to a centralized unwind path that removes the VID
>> from any slave device that was already programmed=2E
>>
>> Signed-off-by: Luka Gejak <luka=2Egejak@linux=2Edev>
>> ---
>>  net/hsr/hsr_device=2Ec | 46 ++++++++++++++++++++++++++----------------=
--
>>  1 file changed, 27 insertions(+), 19 deletions(-)
>>
>> diff --git a/net/hsr/hsr_device=2Ec b/net/hsr/hsr_device=2Ec
>> index 5c3eca2235ce=2E=2E75c491279df8 100644
>> --- a/net/hsr/hsr_device=2Ec
>> +++ b/net/hsr/hsr_device=2Ec
>> @@ -532,8 +532,8 @@ static void hsr_change_rx_flags(struct net_device *=
dev, int change)
>>  static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
>>  				   __be16 proto, u16 vid)
>>  {
>> -	bool is_slave_a_added =3D false;
>> -	bool is_slave_b_added =3D false;
>> +	struct net_device *slave_a_dev =3D NULL;
>> +	struct net_device *slave_b_dev =3D NULL;
>>  	struct hsr_port *port;
>>  	struct hsr_priv *hsr;
>>  	int ret =3D 0;
>> @@ -546,29 +546,28 @@ static int hsr_ndo_vlan_rx_add_vid(struct net_dev=
ice *dev,
>>  			continue;
>>
>>  		ret =3D vlan_vid_add(port->dev, proto, vid);
>> -		switch (port->type) {
>> -		case HSR_PT_SLAVE_A:
>> -			if (ret) {
>> -				/* clean up Slave-B */
>> +		if (ret) {
>> +			switch (port->type) {
>> +			case HSR_PT_SLAVE_A:
>>  				netdev_err(dev, "add vid failed for Slave-A\n");
>> -				if (is_slave_b_added)
>> -					vlan_vid_del(port->dev, proto, vid);
>> -				return ret;
>> +				break;
>> +			case HSR_PT_SLAVE_B:
>> +				netdev_err(dev, "add vid failed for Slave-B\n");
>> +				break;
>> +			default:
>> +				break;
>>  			}
>>
>> -			is_slave_a_added =3D true;
>> +			goto unwind;
>> +		}
>> +
>> +		switch (port->type) {
>> +		case HSR_PT_SLAVE_A:
>> +			slave_a_dev =3D port->dev;
>>  			break;
>>
>
>nit: superflous empty line (it's inconsistent with the other case
>blocks)
>
>>  		case HSR_PT_SLAVE_B:
>> -			if (ret) {
>> -				/* clean up Slave-A */
>> -				netdev_err(dev, "add vid failed for Slave-B\n");
>> -				if (is_slave_a_added)
>> -					vlan_vid_del(port->dev, proto, vid);
>> -				return ret;
>> -			}
>> -
>> -			is_slave_b_added =3D true;
>> +			slave_b_dev =3D port->dev;
>>  			break;
>>  		default:
>>  			break;
>
>I think this would look cleaner with the good and the bad paths in the
>same switch-case, but that may be a matter of (my) taste=2E What do you
>think?
>
>Thanks,
>   Felix
>

Hi Felix,
Thanks for taking a look at v2=2E
>nit: superflous empty line (it's inconsistent with the other case=20
>blocks)
Good catch=2E I'll drop the extra newline in v3=2E
>I think this would look cleaner with the good and the bad paths in=20
>the same switch-case, but that may be a matter of (my) taste=2E What do
> you think?
Very well=2E I will take your preference into consideration and will=20
make mentioned changes in v3=2E However I am not currently home and will
send v3 once I come home in 1-2 days=2E
Best regards,
Luka Gejak

