Return-Path: <netdev+bounces-256783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HZnIpZ+g2mHnwMAu9opvQ
	(envelope-from <netdev+bounces-256783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 18:15:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB02EAEAB
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 18:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34EFA302A075
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 17:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E46633EB06;
	Wed,  4 Feb 2026 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="N+/HSel0"
X-Original-To: netdev@vger.kernel.org
Received: from sonic314-20.consmr.mail.ne1.yahoo.com (sonic314-20.consmr.mail.ne1.yahoo.com [66.163.189.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C69933F37D
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770225163; cv=none; b=LTLUlN0TzEGejHbkscSlRrfjQ2sLYCf9eBUqZmH+WX3RI6q/LBH2LojzB2tdHzd1shNWgAdA4xuu4iPb9VdpoNfw8tBwXEJ1ti5N45pNdU17PJQ9rbLbj51jcmTR1Iatt3GOxW+BP7suowDodELoFbwm8Xx9ZF+3tcDVYsgipkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770225163; c=relaxed/simple;
	bh=0Hy2Bd3elybwCjmfEqj/GpPLAKkIYB5J6cEtufLYNPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lA+usjW6AT9yX3dz1Fh5WF0IxEvKktfF1Nd+zC8h2+N5Tfka0uQHIrWQQKGElpAAsKKd1mg8Pfj6LOFPr8fnUsKvviLK2Rlf3cNdmBGNXyNu0AsEU58wO1rSx+QjeP5/xF9XZlNqf/FXD1WHriVikzrdFs4o1rV3Hr9skCwNCIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=N+/HSel0; arc=none smtp.client-ip=66.163.189.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1770225162; bh=FjFs625tbiJi3Vt3bSwEOcBrDsr7PtUAEn+2aM1qPGo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=N+/HSel0bQYczXuiH2dB2DFIbWMPVrd+CqLdiW3toJY+2jDlsmF7ksj1fKI+EP9M6XXDjht2XypnuNR5cviITKQjDnEJOjktaiu10xNy8kr+pKMQJp+XcBPqcSaKFcsZVlJ94UqpL44FKwWIIQ+hveId7p/1ThT0YxUkyxy//JKIU2ETeBpQJNO1QJSRoHtXfbr153pQ4SefCQweAsLri5xbIqXpeYLFM/24+beJWbfCSgq6UgBd5Jzxno6bolib6lrnxIpQHHz34oKmvO3jRaeUysv2XKFXOrgkrTJQE6o3U3deu+FSrH/MArfYed2muK7ajBBZWfQA1vWcv3hz0A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1770225162; bh=WhMw4lnbhqRMGd2u9EzNw4wXjc+T50zMyttYbKvKJ0l=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=eKWBDQq6rH2ES+e5VhE0VJqByfxBw3EpV48P6wMXdP+YP0uUn+v+1Waj/V6xuBct39J8ibSxRX2UqPYONs4DLndVpmmB//aHx92t+KKn8o9VOckbw7v8B+BbiIlKJzqY/qZFo1or7xBGJPCOG/JESMDQzTdCwVtiTPQirXQ3+eamDFs9FcQl6nESkHk/LrY8mqEK2wk/ru1UUrVQla1/VWY0Mx3xiUsawjOJppPuJGywm9V9L+8IEQu5c3247DIiIbsoXg6AxzWANL7RKmb3uERkAc9VylRCHhTAVQVeLrvVotABQWNN7cQ8j9BZM1bD49ZeSFzQ9Ge55ubzAezvQg==
X-YMail-OSG: AuHOGVsVM1luAUYQlzDXp5udMfSwuVqVPfvVWnFyPP9AEV46.QlG7GvFJMlx6Gm
 bTTo8poSeEk8SKyp4g0umBSepfJ2NqUi0Og_mIsazkkRFiWVmm2o95owH.4TbPvQPaST83MpctAc
 AhK2zB9ZFv7Q8trpYBLdCT3ToztrUnx9GeGf_0Z84q3kv94qyKLvKHVQFeujPLlG.5Vl9ehyYt8S
 d_ub2H9vZXTwjiC7Yn3BO.e9FMkjZoRCwupyUjJrWXSn3ffbNCtBb_96WNVJm_3OGDcJPu4.vBDN
 LTJY5lX4ldYuuEYZCjDhXZS0Eqxm9AZWCJGRV2nZZMt22sdKeJ.bnNUA4PI103znWo.exajF83YA
 w4iYlH5AqcBJckGaotwqdNldzfrM_TPtu5lUgDAFnXtnmRhOqXaKCuKHw67fdWRlSfkVRKf7Z24.
 rh7zUStwzhs1JGpRqwX5_0kzQGzEHlnQzyP3ZULTv4SBLV.ZfLUw.V7gp1el5AB_8.7WiFfZ.UG1
 mv1Zf.Gx1ODqii41pxqipKZtxj.pHXagy1_xrk0YoUtHgEP_pWIZLC_8juswYhKWwSoWp7XmqjnS
 bAT0AE3brf5RHVbjl7nweuhETRjjCBedfMb_galcAfMCSbq_LGsbljEmg7c6EqUiViG77W7U9EdU
 lAZukYTRYJVcJZXkT9dfKcyt.jvZPBIPCBdfO09dIi4kjI6Pun.L9M32lXKW_JipMSeqO.ixVYm5
 xy4hM1COhQXlh9avngZZ0zlzwmNV6oxE8SlYX1YcqZchS6lJUkbqpRbU5sA0lkzdZziYMaqOPzKN
 lmZQED5YbS4pHBUS0zoMrRCMnyed6eFNNBjx4.8DArF9ZOmup9Zp8fIx3W96TLuL9JCceXHaI5a6
 c0mgk18kcM_4.r7QRg_nYaVMnXuhqZSKMy3InCR8UM1Q0ven7pLRWIwS6KnDfZPw531aDtVrf9V6
 SCHTMaXqU1zl7nqVZe1rXpK6N5zerNt4SD_FSdvxVdBFmAajONuPhRYx_f_59stoPoPX0YSarL2h
 6geN.W66_Jq8kYz1bynuT5DWAO6DLWZUxpGiTRdrjfI6rJJBX7E6Z2H5cmWfQMZWNI_Is.ZIuqcf
 CsAve.LWlQKv8W_tcp4qUH9j1hKvpvMclZSYN6ggTDlBGdGME.WXJXu4JCwGF38lRhu14Y.x9p1w
 XVKGAQqVhgGJP2JAP0ZBcG8PUuKQRisdyglHooyq4ssRYL8pDhPie6IFi8OMS6A_eI64vDFO6szJ
 8qkJrx5baLSQ04bSH45efLF3zN7Z5C8W.tqIUbRoXpUAq9iRIlOOgn1u6ciiWleoUya9D1u8t0n7
 UhyrT87O11Yl.Spm2AO7l_4T0jCNPMe4aQUXp5JL1iLjL2puAFXJ3QBmRoljBJdIjAo8MTmY0l7a
 14u0ucTebWPiTqd80s0rlnLxosawVJo5Df63YBIk_UC50nj1TdUSKj.jEC10kgrt2mhZpCKRp3iw
 8wTyg_ISBqivAFXHlweZLD9Ia9fX5PqY8Q6OTavLTDS5ZcvB5acoen4BD2Gp2qAeZ6SVA9XbXU9.
 pahmK2w7NXu_fqv3o_tjC.P4kauSxC41St.Fac74xK5LQKhmWBLFq7immQ82TYsA7zDMOFx5Qo8N
 ocPhp.uDIpslg33_3eBP5G1cE3N1b9O6tzYOgRML3gUxgUWbjla8D716HvbxDT7jL8rvvrJVH7ga
 vsBc4U3Hk9smbUHnicIYaYcGQYYPK5z4sGlKuRXm2v_vRsajRvyEWMzPZveilkQJj9uPuYMKBH.p
 tc.sLmwTbKhS4udQeRY7JfA0TyB5GnOObtzQOAKRzBlmtxTi3b4fCW1B8bAsNGT643Fkeh2SXqL4
 RvsfRE3TdwP_aOJ34U48rieOB_n7atOEpWa3tt40QKKHM9NSbD1Y9ctvQjqWKhz2TLUbuUmVfy6_
 DbF.zMavOW9uLoGwiDGbfQr_Cyt5PKIUMkB784Dh2uuvtKOmDfjXxbzQ1EF58SMThvm0pWmVNYoq
 r1A7Ebs_kiE9kd2rkePF19ZvzSmkmLaMdFO6sDy20AtDrTtn8xQeEby.xWigLC4Z6xRpfrqCTUkD
 Ox0KOKEr_z6hJ9I_OiswY02wz_akthiICBnybzuapIjAXmYHWt9Gvoyq8IU4a2vFOYLkrJx1I5le
 38eW0M8cQuE_VXF64imHOuSfg5KPODQ.SsEWdqW79vAA07ox2
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: d80b78a2-101d-47e3-be8b-a6e24189b36f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 4 Feb 2026 17:12:42 +0000
Received: by hermes--production-ir2-6fcf857f6f-9zs2m (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0eabdce53f9ffe9ab888a38850cb8b93;
          Wed, 04 Feb 2026 16:52:27 +0000 (UTC)
Message-ID: <60baa2a5-806e-4d8b-8601-976fb62fa203@yahoo.com>
Date: Wed, 4 Feb 2026 17:52:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 02/11] net: tunnel: convert iptunnel_xmit to
 noref
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 sd@queasysnail.net, kuba@kernel.org
Cc: Jason@zx2c4.com
References: <20260127070452.6581-1-mmietus97@yahoo.com>
 <20260127070452.6581-3-mmietus97@yahoo.com>
 <e3a7f4b4-3569-422b-873f-0f4e1f11392b@redhat.com>
Content-Language: en-US
From: Marek Mietus <mmietus97@yahoo.com>
In-Reply-To: <e3a7f4b4-3569-422b-873f-0f4e1f11392b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25116 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-256783-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[yahoo.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmietus97@yahoo.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: CDB02EAEAB
X-Rspamd-Action: no action

W dniu 2/3/26 o 09:21, Paolo Abeni pisze:
> On 1/27/26 8:04 AM, Marek Mietus wrote:
>> diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
>> index cf37ad9686e6..a0d699082747 100644
>> --- a/net/ipv6/sit.c
>> +++ b/net/ipv6/sit.c
>> @@ -1028,6 +1028,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
>>  
>>  	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
>>  		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
>> +	ip_rt_put(rt);
>>  	return NETDEV_TX_OK;
>>  
>>  tx_error_icmp:
> 
> Could you please double check that all ndo_start_xmit caller are under
> RCU protection?
> 

The docs in Documentation/networking/netdevices.rst mention that ndo_start_xmit
is called from a BH context or from a process context with BHs disabled.

Ever since the consolidation of the different RCU flavors, running with BHs
disabled implies an RCU read-side critical section. This is mentioned in the docs
for rcu_read_lock_bh.

> Specifically I don't see it in the
> xsk_generic_xmit()/__dev_direct_xmit() path.
> 

As for this, __dev_direct_xmit() calls local_bh_disable() before calling
netdev_start_xmit(), which eventually calls ops->ndo_start_xmit().

> /P
> 
> 


