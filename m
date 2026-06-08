Return-Path: <netdev+bounces-296348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sU9VKccoJmqWSwIAu9opvQ
	(envelope-from <netdev+bounces-296348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 04:28:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 013326523C2
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 04:28:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=Hq75Cpoc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296348-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296348-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 386A93028B27
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 02:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8434231328C;
	Mon,  8 Jun 2026 02:27:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B18313E38;
	Mon,  8 Jun 2026 02:27:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780885623; cv=none; b=DSB2JRjSOOaXf8fKWMCEqz38vJfm8Gk12HiaCsDzwon/uPgTaqNr/wXelF0P7FwUhyC7PxMGBa0hld/d848WZwBJ0okebpZSAJzgYN/P0ES7vBYJK6ElA+Kp74nkfrHvJXZT8NUXEBZZnTkSIEkVCYtQOSpK1YEsAf9v7y865h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780885623; c=relaxed/simple;
	bh=Urqb2KUTDh7lN97wwsy9WV7981XioW0Ai9JSNvl0bkE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GolTYfAW6+aNFKYpUUXroaO1V+rMJiG44rokIty4dms4HXH94r9ZAmg3ajSirqdEzkDIkyBfgc+BK/0tfOy4milzmZSpmuitRkGeqcPInhKGAsNdNlZaXq0FgBlkLyztNq6Zu+nwrv+WNX3/qt0sB5fLP364529tDt/xqqeMpL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Hq75Cpoc; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580EcYd839070;
	Sun, 7 Jun 2026 19:26:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=4tobJTm6x67aSK130z7vcpzjk
	qLRDyu0Xh4WT0q2Mo8=; b=Hq75CpocFoR53AktqdDBSwI/T6kjXfDJ6hZdh7lA4
	N3GiVavNSaEblYKWC/pUQbA/xYdalCrwGL801mkJQzKtHKc/fY2S90hj4WlpisGT
	A+BXZVTLJ55RoRNY8ZtSkY7aPpBW+DZ0TbtM5RJsF7cEIOwYyG6LWuCW9DB0yEgg
	JXdEJA6GmkSBk032gOFUUN2P2Q86vpCu2Fv9JdTIItZFtwrsH2NXAHpD+m/+4sKk
	62DDGy5izZFfiNya1OlOz96ZWEa2arTSi0rf9D7rJc1fAWecPRUxAVO82zXurUnF
	AD6ph7++8lfMS8vPD1TMtSSz53IsTLYkP0Yz80V8HIa4w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4en4a5ja6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 19:26:53 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 7 Jun 2026 19:26:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 7 Jun 2026 19:26:53 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id C91F05B6932;
	Sun,  7 Jun 2026 19:26:49 -0700 (PDT)
Date: Mon, 8 Jun 2026 07:56:48 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v19 net-next 2/9] octeontx2-af: npc: cn20k: debugfs
 enhancements
Message-ID: <aiYoaGp093BqyXqQ@rkannoth-OptiPlex-7090>
References: <20260605063245.3553861-1-rkannoth@marvell.com>
 <20260605063245.3553861-3-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260605063245.3553861-3-rkannoth@marvell.com>
X-Authority-Analysis: v=2.4 cv=HpBG3UTS c=1 sm=1 tr=0 ts=6a26286d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=Fkqlh9ncZL4VOkbnhOEA:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: l0Oku28XjptEyVLIN2ObaNeqGrMaceV_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDAxOSBTYWx0ZWRfX5l9XzqLNL64a
 wTwAtfIL3bFhRt4bnwlh42g71Zhm/p7SaSTIWtC20T6Ix8NMK5G3otmd1l8MnEXbHueTfH31hRA
 RzdyN+m/agZtgv3Rv2qt30++0ONnVEExSM0oiWhQISNSs/0UuVH1vyeLiOWsHq3Yjti8EqaOlvA
 m2CbROWEl1jmjr/PjsRYGKSFd0mqYjt69QA8q/fOhhzWqTsMTSJex9Ay5YThucudkjTRVmn+6hG
 +py4aJZL8xGWbDowm5D6wdngVoIq+qBNh9NS1YCdvh80ioNbmZH+Csfc0pixYNWI7+QAQSYwAYv
 odxAjSJpgFKhfOKf0bXjt/OdTdhaWWrP2mgAIC/nVqBeBoI1K5w1kqs1DXCC/Gz0VQoZs76Uh8y
 hZbNGp9UoIsYQ8rAFPllIF4K0glBE4o3MBdOoosqdypr5qIlKEFxn6YDHPzuL2FCxBaIcSi0SH7
 l2jvYfv6SPbAS3zEt1A==
X-Proofpoint-GUID: l0Oku28XjptEyVLIN2ObaNeqGrMaceV_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-296348-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rkannoth-OptiPlex-7090:mid,linux.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:dkim,marvell.com:from_mime,marvell.com:email];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 013326523C2

On 2026-06-05 at 12:02:38, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Improve MCAM visibility and field debugging for CN20K NPC.
>
> - Extend "mcam_layout" to show enabled (+) or disabled state per entry
>   so status can be verified without parsing the full "mcam_entry" dump.
> - Add "dstats" debugfs entry: for enabled MCAM indices, print hit deltas
>   since the prior read by comparing hardware counters to a per-entry
>   software baseline and advancing that baseline after each read (hardware
>   counters are not cleared).
> - Add "mismatch" debugfs entry: lists MCAM entries that are enabled
>   but not explicitly allocated, helping diagnose allocation/field issues.
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260605063245.3553861-1-rkannoth%40marvell.com says

t
>> +			stats = rvu_read64(rvu, blkaddr,
>> +					   NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(idx, bank));
>> +			if (!stats)
>> +				continue;
>> +			if (stats == dstats[bank][idx])
>> +				continue;
>> +
>> +			if (stats < dstats[bank][idx])
>> +				dstats[bank][idx] = 0;
>Can dstats[bank][idx] overflow this static array?
No. This array is allocated with Max values.
MAX_NUM_BANKS, MAX_SUBBANK_DEPTH and MAX_NUM_SUB_BANKS

>The header comment asserts that MAX_NUM_BANKS, MAX_NUM_SUB_BANKS and
>MAX_SUBBANK_DEPTH are hard limits "preventing any possibility of
>out-of-bounds access", but npc_priv_init() does not enforce that
>contract on bank_depth itself. It only checks num_banks, num_subbanks,
>and subbank_depth = bank_depth / num_subbanks.
>bank_depth maximum across SoC is 8192. We will add a check for num_subbnks as well
>as part of hardening series to net-next once this patch series is merged.
Will add a check on bank_depth in npc_priv_init() in hardening patch series to
net-next after this series is merged.

>Is the dstats baseline correct on the first read, and after an MCAM slot
>is freed and reallocated?
>The commit message describes dstats as printing "hit deltas since the
>prior read by comparing hardware counters to a per-entry software
>baseline and advancing that baseline after each read". The baseline
>dstats[bank][idx] is keyed only by physical hardware slot.
>On the first read after module load, dstats[bank][idx] is 0, so:
>	delta = stats - dstats[bank][idx];
>prints the cumulative counter rather than a delta.
>When an MCAM slot is freed and reallocated to a different rule or PF
>(and the hardware counter is preserved across moves, as
>npc_defrag_move_vdx_to_free does via rvu_write64(... STAT_EXT ...,
>stats)), the retained baseline mixes counts that belonged to the
>previous owner into the delta attributed to the new PF.
>Should the baseline be cleared inside npc_cn20k_enable_mcam_entry() on
>each enable/disable transition, in addition to whatever happens on read?
>Is reading dstats meant to be destructive?
>Each read advances dstats[bank][idx] = stats, so two concurrent readers
>(for example a monitoring daemon and a human admin) race for events:
>whichever reads first advances the baseline, and the other sees zero
>deltas for entries it would otherwise have observed. Most observability
>files under debugfs/procfs/sysfs are passive snapshots so multiple tools
>can scrape them concurrently. Would a snapshot file plus userspace delta
>computation, or a separate write-to-clear sibling, fit better here?

"dstats" is for live debugging in field, where user wants to know which NPC
mcam entry is being hit. This debugfs entry helps to identify the mcam entry.
If mcam entry is allocated/deallocated/allocated again, first time 'cat'ing debugfs
entry, may show wrong delta. But next time, it will show the correct value as s/w
baseline array would have updated to the hw stats value correctly.

>> +
>> +			pf = 0xFFFF;
>> +			map = xa_load(&npc_priv->xa_idx2pf_map, mcam_idx);
>> +			if (map)
>> +				pf = xa_to_value(map);
>> +
>> +			delta = stats - dstats[bank][idx];
>> +
>> +			snprintf(buff, sizeof(buff), "%u\t%#04x\t%llu\n",
>> +				 mcam_idx, pf, delta);
>> +			seq_puts(s, buff);
>> +
>> +			dstats[bank][idx] = stats;
>> +		}
>> +	}
>> +
>> +	mutex_unlock(&stats_lock);
>> +	return 0;
>> +}
>> +
>> +/*  "%u\t%#04x\t%llu\n" needs less than 64 characters to print */
>> +#define TOTAL_SZ (MAX_NUM_BANKS * MAX_NUM_SUB_BANKS * MAX_SUBBANK_DEPTH * 64)
>> +DEFINE_OCTEONTX2_DEBUGFS_ATTRIBUTE_WITH_SIZE(npc_mcam_dstats, TOTAL_SZ);
>Is the up-front 1 MiB allocation per open() necessary here?
>TOTAL_SZ evaluates to MAX_NUM_BANKS * MAX_NUM_SUB_BANKS *
>MAX_SUBBANK_DEPTH * 64 = 1,048,576 bytes, and single_open_size() asks
>seq_file to preallocate that buffer regardless of how much the file
>actually emits. dstats only emits lines for entries with changed
>counters, and mismatch is typically a few lines.
>The size also does not scale to the actual hardware geometry; it uses
>the MAX constants instead of npc_priv->num_banks * npc_priv->bank_depth.
>Could the standard seq_file iterator pattern (start/next/stop/show via
>DEFINE_SHOW_ATTRIBUTE) be used instead, so the buffer grows on demand.

BUffer is pre allocated to the maximum required.

>>  	}
>>
>> @@ -4513,10 +4527,15 @@ static int npc_priv_init(struct rvu *rvu)
>>  		return -EINVAL;
>>  	}
>>
>> -	npc_priv.num_subbanks = num_subbanks;
>> -
>>  	subbank_depth =	bank_depth / num_subbanks;
>> +	if (subbank_depth > MAX_SUBBANK_DEPTH) {
>> +		dev_err(rvu->dev,
>> +			"Invalid subbank depth %u\n",
>> +			subbank_depth);
>> +		return -EINVAL;
>> +	}
>>
>> +	npc_priv.num_subbanks = num_subbanks;
>>  	npc_priv.bank_depth = bank_depth;
>>  	npc_priv.subbank_depth = subbank_depth;
>Tying back to the dstats overflow question above: bank_depth itself is
>not bounded here. With hardware reporting bank_depth = 8193 and
>num_subbanks = 32, integer division gives subbank_depth = 256, which
>passes this check, but bank_depth still exceeds MAX_NUM_SUB_BANKS *
>MAX_SUBBANK_DEPTH = 8192. Should there be an explicit check on
>bank_depth, or a check that bank_depth == subbank_depth * num_subbanks,
>to keep the en_map bitmap and dstats[][] within their declared sizes?
bank_depth is less than MAX_BANK_DEPTH in all Soc. WIll add a check in
next patch series (hardening series to check against bank_depth <= MAX_BANK_DEPTH)
int npc_priv_init() (During probe())

