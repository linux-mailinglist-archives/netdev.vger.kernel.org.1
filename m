Return-Path: <netdev+bounces-288696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKoEJt5qCWqeZAQAu9opvQ
	(envelope-from <netdev+bounces-288696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 09:14:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DA955FA11
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 09:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 485013009F82
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 07:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC941308F0A;
	Sun, 17 May 2026 07:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KalGupVJ"
X-Original-To: netdev@vger.kernel.org
Received: from sonic316-22.consmr.mail.ne1.yahoo.com (sonic316-22.consmr.mail.ne1.yahoo.com [66.163.187.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640B52D46C0
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 07:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779002058; cv=none; b=JYIUyead+Z/riqrvQI4fRS5Q9TMZvFwoyBgq+ntQj6s/0Dvf+zBRr+E1DhIPe2TNcQaP2MnFRp43+ZQWWcrsFsSDf2V+HoejlJB+LMX2ycnxJtdu/74IQmGD7Vio/PAdoM7Dsx5t+M91QGbHkYUgwdiZVvGc2H+zvBOcPtdNfLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779002058; c=relaxed/simple;
	bh=TxI6yUkOsCYt17vW77re+oBARTSLya4T3cCNoDeNAFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fP53y86K+ZnXqmsNBU9IpG0KhGZYEmv9vxf8yPtznntONEmRJiOAvXh2oTb0QbPT21CP8ZJRkfplgBowb80IrkpUZPdJuriYderR7Tel3JZ9gyS5OLB0rctzuoQwSh+531R0+LIi1pFEGHmyzofPZ96GCi2PGeXfdfRJz/w2Yx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=KalGupVJ; arc=none smtp.client-ip=66.163.187.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1779002056; bh=eqD48QuVXN8aWQrdlCb4t87R/mXMsQ33mIlYPls/ym8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=KalGupVJKqT6DJ7ucvOlDDVFJPuXdGy6hdMlEJCRU4FlVfWeCMEbzIlN2ST8E/j44rtDuQkqxTzgMOyvqYrTc5s0oxKWfz/HXDAR+Peud7fSDJbv5gzs0Q7Np24kzZZ2KtRENrz7ojOzcBMC0w1a06OjyzmHoEOwViYBr6I+1ncwqPk8+wO8hoJAICX1FeR/+faXp2IZyjjOmjvM0j+RSvhrVM5+ewmNPrOILfHXuYFtnT9fo1x9BDVFF4832KA2/nuCuRUR4P8TkvVGV4VCZGVmUln4cZgtQ907Veo6hcUC3sMa0+nASpj8ybr6pipBkrVaoJOwaiuhYIic0aVejw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1779002056; bh=y7P7LVxypAUcmzmbNE+wlaWmrzHIZ5lgHMSmx3Z/3JN=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=UooKgQR2nOtuJAx7mMpMgxkZ6ybCJuQEGjvE0SzbzP8Zgy1JM/VS/jLIRFUg7zA24WABr5KB2D/Ci18pFZNL0I1xKI2T628BTp1QHzad+elYa0VCmE3U17FeQ0nA6wUvQqiEXroGGVF9q3OwoED6PfmMOAfh6vwZnM/XG9bBx5CvMzq8Jc8t9cTt8zhstq3ATX7d+DDnQJ0osXSzCrqklqbq/GE2bSxMec71GsX4LJP+4cws1xJjtOXaqwSPAwamYsj1AhE1OmW+CCKXoMzUYSZ71/AB9ymrNxtDqEQ/3TuttG4ErN60YMqgLAUUA/zDzX0iJPnELaZtaKtyN5vGiA==
X-YMail-OSG: UGcplvMVM1mHTTSar8qDpsoJro7QCHxEa4Thd7IX2pfY7YvApyqDwq7f.LYFVbs
 wek6Zw4r0uATw76bS5IhNeK8q2FYnvnEos1nwthlzyIMjbrcPnvRoHiXbvoFS3EqKQUHSvJmWTdT
 0QCeMZeizmdfL3lTY0YRfLPUvqZqmOXw2Dfkcpa34K2RqaaKL04qJBe0x4NU_.dJNTwTlxk7g4Di
 uyefDizBC_ztnogTQUJvYISE6UoAMRkuN0ut8UBKHsdb.J_Gw_KBHprQirBrpwmC6G7tST_nprrG
 QFVYGwNyxY_MtMXlnaJyLjrTmKafj4mw7TVCqn6_cmb6ZMcfG1e4GoszRTDfyYjbLvMStPjYhHLK
 rCho_VoWZ19YWtgYrvOq5XL2pha31ydPQ0CtqJvW0b9loZ0SEPt5klLaaJCBTMeiifqt8E6AoGYo
 FRDskbgW7BYT0kH7vPCbYQ6Nvs4vA.FoiwY1yU8w74vdKRL8756ifsCczkP2wYUSCofT6gpTpDRB
 y61nwI2H_twRza2i7eCacZeDGJ.1tpgUq9n37s0cGgu9tEtvZFqdlCPnnba2x4nD4UABDeo7dvYs
 xYnswkDLJSaMOcEj6K16SO3n1_EIvxig4UBCo9V1WjPiVUtTcxs3LfKNTRbbZNrPot5DuQBaeQrN
 02JFnWR4E7b2Muo00dv9UYFyBVeJFvo68U1PHHo0G5THGHCJapYpUhMGGNaku9ftMm2RNsGYnVa_
 gUMX1FBoc1csrXB5RMm1zQwp9347YBQfNgByR9u_kn7UBNFzs7FjCa7JkCiu6Rbv8PwLNHeMidpZ
 dy1oeQrmRtkEsIIyxNCfFzTzvZjBIhCl7P..Xg0cHtShalQxfePcVOADwm2M6XNnngThddVpPVDR
 3Eb8.0M475u5tBm0kXGLOdmyhdpFSLMGuWJAjWpGBB2dle7TubvQ5xOHS8uo4.xBFq6zWICqn29A
 63D1Dyckgl5vdgLkKvzzPqT.uXw26JHXH2BJZTqlQCiK97WVKfUpqsA5viCIfV6cHzt4mu6BXg5C
 m9XPajGT9RFhw560rHZyWQTE.OtCooUyjJeitZoqjeonhLCRAwohVPwXhelQTAWhCxROH6LJnSge
 2hR__fDimxahAAXkkBSWU9lJrDAwWQK8rw6_ZPWDNlp5RdjhlfAdd8_zaKv5Q7ogbBky7tMsPDDl
 Q1WN0h54oJSyzAr_DIIyVkHozQZBCymZEdmnqw6PFMA8BklkMET2Jygweid0Ny3Upp.SiQQESfcs
 Jk5nKqBTpagNxWlXemEAnyQseyIlGWk2AriKiTjczfwJlHoibPo1q7QSWZtECSZ.csgXAvLhmZIe
 fdya0SqBmpNM1cfqnp5jnMl44IdQ_gKFEPeJhAWBt7R1cGPhv.UKhV0En1XwYgndzHcIfoPSFXa9
 56naWDXA4Et14Gd8.x7CJN_yWpQ30DxcmOxd0ojOKuBiljuCJNPEf7wO1vN.RzwoO6EKQMTQ0FR2
 aZ3qb6pGhPn3JfF8kJZy1deXSsZnQtiR1cZABAUNSDubLGdHrlj9LAkWW6RiCHLQ6whCZvjgo..g
 .b1rXmdR67mksjIL8I5RodYRQCdkSlz12QxbgSy0PjzDRlceFoTixHIfkPHnUBGyovZ9CqSVR1FP
 UwcgvF_RCU0kygpymO0EpaUkZrvUlOq_kk69FeSFHYVDJ3ulvnw8ZAw1lkPHrd5n2Adf0hECJLwe
 ic_AMuLgCKzegksTC3MH2szePvUA3cUW2FRJz1iljiN59dNjqXZiDye.8TvQ.hupKhoogfmKkIx_
 SkHcO0eQxsAf2jVEbhNFqUyuxD3WUnqT1NVTUN2kbkvtxBop8rZ0YXvg2TIqk5NwHDcWguvO7_RG
 7TViq_J4ThRgiCI3SsP2bI1V2X9tQ1OkX0TbwLFZ5JkaGjkp18VdJ04oWp3Z1LJgbklP_iq5Zky0
 X7iVH1_K2wfbXY90.5mypLKtwsyr6pt7Tur.IyDVp8ADcf1SSRp7uA1UKxr97t4Jjm5tb69QBJSR
 cmS2NfyV1Y9p1AoLgxoHj3UqNhGso1HWTJX5WaeMGYRpTeSlO2eZ8HC2bnvyN_JnVHXlAG_oSjsv
 NGqhL9wDZvv1LwFsW8HsCP3CMILN1arw1AWRQfabk2HzLKqpMblvlVZ71N_1eJ5kOp9tAvtamYls
 J.WuUkf5pQ78pUVZhNQfn1F1Pm7nHic_BGNQMa3YN3SCt1jNcUA8DfIQY37qIpZDemXIruttpqLM
 zIBpUR4rJ4AXJ1dQMSrqefDJvcqT_YNDqRpLL_Gcvl2FHeD7ogkIjMGFdNYVlbMU1ehS.NxqMFXK
 d5kMtAd0jbhUYhRdSuaooOx_MgVTgW7IGgqyWQhWTD_dZdtQ-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: aa01225a-701e-47fb-b798-eb24c9899c5f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Sun, 17 May 2026 07:14:16 +0000
Received: by hermes--production-ir2-89844b765-6gbsd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2dac59f4c51d1cc16ebb8c72f4716054;
          Sun, 17 May 2026 06:53:32 +0000 (UTC)
Message-ID: <7d2dbd71-b82c-4ff0-97ed-3af39143289f@yahoo.com>
Date: Sun, 17 May 2026 08:53:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v4 2/8] net: dsa: realtek: rtl8365mb: use dsa
 helpers for port iteration
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Abdulkader Alrezej <abdulkader.alrezej@gmail.com>
References: <20260516-realtek_forward-v4-0-8b6d6a1eefdc@gmail.com>
 <20260516-realtek_forward-v4-2-8b6d6a1eefdc@gmail.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260516-realtek_forward-v4-2-8b6d6a1eefdc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25725 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Queue-Id: 06DA955FA11
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288696-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/16/2026 5:46 AM, Luiz Angelo Daros de Luca wrote:
> Use dsa_switch_for_each_*() whenever possible.
> 
> For port setup(), a new blocking setup phase was added for all ports,
> including unused ones, before the user and CPU port setup.
> 
> CPU isolation includes all user ports as traffic was being blocked in
> some scenarios (suggested by Abdulkader Alrezej).
> 
> The driver bails out if a DSA port is detected as the driver was not
> tested in a cascading setup.
> 
> Suggested-by: Abdulkader Alrezej <abdulkader.alrezej@gmail.com>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---> [...]> @@ -1974,46 +1978,83 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
>  	else if (ret)
>  		dev_info(priv->dev, "no interrupt support\n");
>  
> -	/* Configure CPU tagging */
> -	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
> -		cpu->mask |= BIT(cpu_dp->index);
> +	/* Start with all ports blocked, including unused ports */
> +	dsa_switch_for_each_port(dp, ds) {
> +		struct rtl8365mb_port *p = &mb->ports[dp->index];
>  
> -		if (cpu->trap_port == RTL8365MB_MAX_NUM_PORTS)
> -			cpu->trap_port = cpu_dp->index;
> -	}
> -	cpu->enable = cpu->mask > 0;
> -	ret = rtl8365mb_cpu_config(priv);
> -	if (ret)
> -		goto out_teardown_irq;
> -
> -	/* Configure ports */
> -	for (i = 0; i < priv->num_ports; i++) {
> -		struct rtl8365mb_port *p = &mb->ports[i];
> +		if (dsa_port_is_dsa(dp)) {
> +			dev_err(ds->dev, "Cascading (DSA links) not supported");
> +			return -EOPNOTSUPP;
> +		}
>  
Missing trailing \n in the format string. Kernel dev_err() messages aren't auto-newlined by the logging machinery — without one, this line will be glued to whatever subsequent printk follows. Every other dev_err/dev_info in this driver (e.g. the dev_info(priv->dev, "no interrupt support\n"); a few lines above) terminates with \n


