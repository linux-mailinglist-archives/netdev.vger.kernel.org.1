Return-Path: <netdev+bounces-299612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K62xJyRkMGoHSgUAu9opvQ
	(envelope-from <netdev+bounces-299612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:44:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBE168A08C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:44:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299612-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299612-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 396AD3023306
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057F13B71A0;
	Mon, 15 Jun 2026 20:44:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532393B6C15
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 20:44:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781556256; cv=none; b=jsxEDdRz8sPXmFYxNRhIN3twjzFgxTJKec24mHKrJBub08TKIBPmEQedOMa/iQnMmsafnhI5z/MiQDJdjBZbd1dt29mofZ2FeWvo5sbLKBmD2s/5nT1vEbhaL0fBOixEucnn907gzyUczwUyCfOUaYi703xbs2x6t77qJTxoDCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781556256; c=relaxed/simple;
	bh=aQGSmhqwLOqjMUzbL85WZ9+bn0X2W2orb9+HK//AE+s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SuoDLJKRhwWAiLHBcf29A0AQ4UnIlcUhR8O09iExVNqMssy764Dya6lcZwgb5uTqTiLwW1iEklxgldhXKI1VAMnVhWOcuWPY3cnox7Du5FDEliPOPXN3183gar3dxhgczBo5w5Io5l+DR23LJSG6R7p+qk6/fjfGslmb4+HNMTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.67
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-45eeea039ebso2146989f8f.1
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 13:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781556254; x=1782161054;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sm4VpBpIyAq2Mm84nopki5i3qfs9ksFX2hx165N0cX4=;
        b=L1fLqTlUPzj/agF6NLJGhYDEZkSVBJjWz4QOt6kvetQji2KuNp6wq+R1EcL2bhMQgy
         YKtvOHNt3IgcTFW4cfV2ibqfUUWYWfAP3NzGx5t8eITICDdEUqB6L/DnS0E+bnB2EwaW
         Mxlrf50K/pKs24yJNPqw8YJ5VGZ1Pp7ps0nUeO6cM/XZvq1jn8m7QGZPQIbOorAFPL8V
         Xvl9SvrMHLuXfobLTJMIe3R7HUrkIesf2oBR1jSHP73+Rgh8SIF0p38++lBvNdqTu1H+
         phRdFe1ltCIWqJAvCiZJ7MeNoW6XJ1rQPiI1PmkavxnmGUyFkP1sdRRiHMUe99zXmQhU
         9YuA==
X-Forwarded-Encrypted: i=1; AFNElJ+C+ujmikbQ293Nt/lJC2OdCZSYV8dLTK+VFCavrkVyhXbsHBF0ZE6RRfcTPbvsr1emx+giqvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpg77E8eRUykJL5krSQcdspZBSk7g8ihTzKG038nOYQR5ucI6u
	jLoVfOB6pW7FGAZg2P2kZytKdRsFkLxttoGllEkIlXpcm6RB5/QHb5YC
X-Gm-Gg: Acq92OG/eZzoVEUXspMk9YrqjomU/ZER+wSKoURkPV0dogvHMrp6HuW632vfeR/NWy9
	GRUz1ggEv6aJPh0QFQJZzFBqMN139CTwNFGUBrzwxn6kG09CrZhcY9I1Hp7FQx54fcJK04x2ZiU
	bz2WH+T/jqKwyfL3PC/GOaqoB0mNNzDFWoxZBHmq24bFnhmDZBHElpgvc6VheP/I8ivh6rGbMBo
	fSnkCYlsRh+z6TZb3dZ9X+ie53pWaCRva1NxX0FgrVXwzGC45cs7p5h2Sb6hHumb5Y+wSDqdYJQ
	gG7ITsw1C87AFutgzi4a4gGnULKbM4jNZcxWC8xeKFnyaolv7udQZUZhAWMZms3HYcimdYiTHK/
	r4ezdKsBACdX60+m+0bOagjSIrbTThKWQEzkc5YPyBlpF4lfgqNkoR1Ka53r1jp5QxTD8JST7jS
	FZVaER86c5xsvv4Sa7dsjXsxgT/8IVZG6VYOMpEP6BQCYtDfE7ioNcCFmgjp9y1VmLWw==
X-Received: by 2002:a05:6000:2684:b0:45e:ea68:523e with SMTP id ffacd0b85a97d-46076b18bdbmr18206989f8f.21.1781556253445;
        Mon, 15 Jun 2026 13:44:13 -0700 (PDT)
Received: from [192.168.88.241] (89-24-32-234.nat.epc.tmcz.cz. [89.24.32.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2cd6c2sm37552171f8f.30.2026.06.15.13.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 13:44:12 -0700 (PDT)
Message-ID: <ec0c5fe3-aee5-4d6a-b022-7039cdf47b91@ovn.org>
Date: Mon, 15 Jun 2026 22:44:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Johan Thomsen <write@ownrisk.dk>,
 netdev@vger.kernel.org, dev@openvswitch.org
Subject: Re: [BUG] FORTIFY: memcpy overflow in skb_tunnel_info_unclone() from
 geneve_xmit()
To: Kees Cook <kees@kernel.org>
References: <CAKv6aAM8_EWgXScnKmKYm_4SwGDVBK++dzfP+Y6msUXbp99QUw@mail.gmail.com>
 <18972686-936d-4fb0-850f-7e212c48ab97@ovn.org>
 <202606101245.549180BC85@keescook>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 xsFNBF77bOMBEADVZQ4iajIECGfH3hpQMQjhIQlyKX4hIB3OccKl5XvB/JqVPJWuZQRuqNQG
 /B70MP6km95KnWLZ4H1/5YOJK2l7VN7nO+tyF+I+srcKq8Ai6S3vyiP9zPCrZkYvhqChNOCF
 pNqdWBEmTvLZeVPmfdrjmzCLXVLi5De9HpIZQFg/Ztgj1AZENNQjYjtDdObMHuJQNJ6ubPIW
 cvOOn4WBr8NsP4a2OuHSTdVyAJwcDhu+WrS/Bj3KlQXIdPv3Zm5x9u/56NmCn1tSkLrEgi0i
 /nJNeH5QhPdYGtNzPixKgPmCKz54/LDxU61AmBvyRve+U80ukS+5vWk8zvnCGvL0ms7kx5sA
 tETpbKEV3d7CB3sQEym8B8gl0Ux9KzGp5lbhxxO995KWzZWWokVUcevGBKsAx4a/C0wTVOpP
 FbQsq6xEpTKBZwlCpxyJi3/PbZQJ95T8Uw6tlJkPmNx8CasiqNy2872gD1nN/WOP8m+cIQNu
 o6NOiz6VzNcowhEihE8Nkw9V+zfCxC8SzSBuYCiVX6FpgKzY/Tx+v2uO4f/8FoZj2trzXdLk
 BaIiyqnE0mtmTQE8jRa29qdh+s5DNArYAchJdeKuLQYnxy+9U1SMMzJoNUX5uRy6/3KrMoC/
 7zhn44x77gSoe7XVM6mr/mK+ViVB7v9JfqlZuiHDkJnS3yxKPwARAQABzSJJbHlhIE1heGlt
 ZXRzIDxpLm1heGltZXRzQG92bi5vcmc+wsGUBBMBCAA+AhsDBQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAFiEEh+ma1RKWrHCY821auffsd8gpv5YFAmfB9JAFCQyI7q0ACgkQuffsd8gpv5YQ
 og/8DXt1UOznvjdXRHVydbU6Ws+1iUrxlwnFH4WckoFgH4jAabt25yTa1Z4YX8Vz0mbRhTPX
 M/j1uORyObLem3of4YCd4ymh7nSu++KdKnNsZVHxMcoiic9ILPIaWYa8kTvyIDT2AEVfn9M+
 vskM0yDbKa6TAHgr/0jCxbS+mvN0ZzDuR/LHTgy3e58097SWJohj0h3Dpu+XfuNiZCLCZ1/G
 AbBCPMw+r7baH/0evkX33RCBZwvh6tKu+rCatVGk72qRYNLCwF0YcGuNBsJiN9Aa/7ipkrA7
 Xp7YvY3Y1OrKnQfdjp3mSXmknqPtwqnWzXvdfkWkZKShu0xSk+AjdFWCV3NOzQaH3CJ67NXm
 aPjJCIykoTOoQ7eEP6+m3WcgpRVkn9bGK9ng03MLSymTPmdINhC5pjOqBP7hLqYi89GN0MIT
 Ly2zD4m/8T8wPV9yo7GRk4kkwD0yN05PV2IzJECdOXSSStsf5JWObTwzhKyXJxQE+Kb67Wwa
 LYJgltFjpByF5GEO4Xe7iYTjwEoSSOfaR0kokUVM9pxIkZlzG1mwiytPadBt+VcmPQWcO5pi
 WxUI7biRYt4aLriuKeRpk94ai9+52KAk7Lz3KUWoyRwdZINqkI/aDZL6meWmcrOJWCUMW73e
 4cMqK5XFnGqolhK4RQu+8IHkSXtmWui7LUeEvO/OwU0EXvts4wEQANCXyDOic0j2QKeyj/ga
 OD1oKl44JQfOgcyLVDZGYyEnyl6b/tV1mNb57y/YQYr33fwMS1hMj9eqY6tlMTNz+ciGZZWV
 YkPNHA+aFuPTzCLrapLiz829M5LctB2448bsgxFq0TPrr5KYx6AkuWzOVq/X5wYEM6djbWLc
 VWgJ3o0QBOI4/uB89xTf7mgcIcbwEf6yb/86Cs+jaHcUtJcLsVuzW5RVMVf9F+Sf/b98Lzrr
 2/mIB7clOXZJSgtV79Alxym4H0cEZabwiXnigjjsLsp4ojhGgakgCwftLkhAnQT3oBLH/6ix
 87ahawG3qlyIB8ZZKHsvTxbWte6c6xE5dmmLIDN44SajAdmjt1i7SbAwFIFjuFJGpsnfdQv1
 OiIVzJ44kdRJG8kQWPPua/k+AtwJt/gjCxv5p8sKVXTNtIP/sd3EMs2xwbF8McebLE9JCDQ1
 RXVHceAmPWVCq3WrFuX9dSlgf3RWTqNiWZC0a8Hn6fNDp26TzLbdo9mnxbU4I/3BbcAJZI9p
 9ELaE9rw3LU8esKqRIfaZqPtrdm1C+e5gZa2gkmEzG+WEsS0MKtJyOFnuglGl1ZBxR1uFvbU
 VXhewCNoviXxkkPk/DanIgYB1nUtkPC+BHkJJYCyf9Kfl33s/bai34aaxkGXqpKv+CInARg3
 fCikcHzYYWKaXS6HABEBAAHCwXwEGAEIACYCGwwWIQSH6ZrVEpascJjzbVq59+x3yCm/lgUC
 Z8H0qQUJDIjuxgAKCRC59+x3yCm/loAdD/wJCOhPp9711J18B9c4f+eNAk5vrC9Cj3RyOusH
 Hebb9HtSFm155Zz3xiizw70MSyOVikjbTocFAJo5VhkyuN0QJIP678SWzriwym+EG0B5P97h
 FSLBlRsTi4KD8f1Ll3OT03lD3o/5Qt37zFgD4mCD6OxAShPxhI3gkVHBuA0GxF01MadJEjMu
 jWgZoj75rCLG9sC6L4r28GEGqUFlTKjseYehLw0s3iR53LxS7HfJVHcFBX3rUcKFJBhuO6Ha
 /GggRvTbn3PXxR5UIgiBMjUlqxzYH4fe7pYR7z1m4nQcaFWW+JhY/BYHJyMGLfnqTn1FsIwP
 dbhEjYbFnJE9Vzvf+RJcRQVyLDn/TfWbETf0bLGHeF2GUPvNXYEu7oKddvnUvJK5U/BuwQXy
 TRFbae4Ie96QMcPBL9ZLX8M2K4XUydZBeHw+9lP1J6NJrQiX7MzexpkKNy4ukDzPrRE/ruui
 yWOKeCw9bCZX4a/uFw77TZMEq3upjeq21oi6NMTwvvWWMYuEKNi0340yZRrBdcDhbXkl9x/o
 skB2IbnvSB8iikbPng1ihCTXpA2yxioUQ96Akb+WEGopPWzlxTTK+T03G2ljOtspjZXKuywV
 Wu/eHyqHMyTu8UVcMRR44ki8wam0LMs+fH4dRxw5ck69AkV+JsYQVfI7tdOu7+r465LUfg==
In-Reply-To: <202606101245.549180BC85@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299612-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	FORGED_RECIPIENTS(0.00)[m:i.maximets@ovn.org,m:write@ownrisk.dk,m:netdev@vger.kernel.org,m:dev@openvswitch.org,m:kees@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,ovn.org:mid,ovn.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EBE168A08C

On 6/10/26 9:51 PM, Kees Cook wrote:
> On Mon, Jun 08, 2026 at 11:41:37AM +0200, Ilya Maximets wrote:
>> On 6/8/26 10:25 AM, Johan Thomsen wrote:
>>> Hello,
>>>
>>> I am seeing what looks like a kernel bug in the Geneve/OVS/vhost
>>> transmit path on a Talos Linux node running Kube-ovn with Geneve
>>> overlay and KubeVirt VM traffic.
>>>
>>> Environment:
>>>
>>> Kernel: 6.18.33-talos
>>> Distro: Talos v1.13.3
>>>
>>> Compiler/config:
>>>
>>> CONFIG_CC_VERSION_TEXT="clang version 22.1.2"
>>> CONFIG_CC_IS_CLANG=y
>>> CONFIG_LTO=y
>>> CONFIG_LTO_CLANG=y
>>> CONFIG_LTO_CLANG_THIN=y
>>> CONFIG_FORTIFY_SOURCE=y
>>>
>>> Hardware: HPE ProLiant DL325 Gen11, AMD EPYC
>>>
>>> NIC driver: bnxt_en
>>>
>>> Workload/network:
>>>
>>> Kube-OVN, Geneve overlay
>>> Open vSwitch datapath
>>> KubeVirt/QEMU VM traffic via vhost/tap
>>>
>>> Relevant console output:
>>>
>>> [  648.742603] memcpy: detected buffer overflow: 104 byte write of
>>> buffer size 96
>>> [  648.749907] WARNING: CPU: 61 PID: 27020 at
>>> lib/string_helpers.c:1036 __fortify_report+0x45/0x60
>>> [  648.758689] Modules linked in: dm_round_robin dm_multipath lpfc
>>> nvmet_fc nvmet intel_rapl_msr intel_rapl_common ahci nvme_auth bnxt_en
>>> nvme hpilo hkdf libahci sp5100_tco watchdog k10temp
>>> [  648.775429] CPU: 61 UID: 107 PID: 27020 Comm: vhost-27002 Not
>>> tainted 6.18.29-talos #1 PREEMPT(none)
>>> [  648.784735] Hardware name: HPE ProLiant DL325 Gen11/ProLiant DL325
>>> Gen11, BIOS 2.84 11/05/2025
>>> [  648.890478]  skb_tunnel_info_unclone+0x179/0x190
>>> [  648.895152]  geneve_xmit+0x7fe/0xe00
>>> [  648.907240]  dev_hard_start_xmit+0xa7/0x1f0
>>> [  648.911479]  __dev_queue_xmit+0x864/0xf40
>>> [  648.919688]  do_execute_actions+0x9b9/0x1be0
>>> [  648.927727]  ovs_execute_actions+0x58/0x170
>>> [  648.931960]  ovs_dp_process_packet+0xb1/0x1c0
>>> [  648.936370]  ovs_vport_receive+0x90/0x100
>>> [  648.940428]  netdev_frame_hook+0x146/0x1a0
>>> [  648.954093]  __netif_receive_skb+0x3f/0x160
>>> [  648.958324]  process_backlog+0x10c/0x210
>>> [  648.962295]  __napi_poll+0x2f/0x190
>>> [  648.965832]  net_rx_action+0x2e3/0x500
>>> [  648.969632]  handle_softirqs+0xe7/0x310
>>> [  648.985387]  tun_get_user+0x137e/0x1510
>>> [  649.005878]  handle_tx+0x41f/0xd30
>>> [  649.029014]  vhost_run_work_list+0x52/0x90
>>> [  649.033162]  vhost_task_fn+0xc2/0x140
>>> [  649.064145] ---[ end trace 0000000000000000 ]---
>>> [  649.068820] ------------[ cut here ]------------
>>> [  649.073489] kernel BUG at lib/string_helpers.c:1043!
>>>
>>> I don't know whether this is a real overflow or a FORTIFY false-positive.
>>
>> Looks like a false-positive from the __counted_by fortification.
>>
>> I'd guess something like this would fit it:
>>
>> diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
>> index 1fc2fb03ce3f9..e51c3795da474 100644
>> --- a/include/net/dst_metadata.h
>> +++ b/include/net/dst_metadata.h
>> @@ -164,6 +164,7 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
>>  	if (!new_md)
>>  		return ERR_PTR(-ENOMEM);
>>  
>> +	new_md->u.tun_info.options_len = md_size;
>>  	memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
>>  	       sizeof(struct ip_tunnel_info) + md_size);
> 
> Speaking to this solution, it also makes sense, but does look redundant
> to the memcpy that follows it. I wonder something more in between would
> be better (the memcpy isn't needed to copy a struct, either):
> 
> 	new_md->u.tun_info = md_dst->u.tun_info;

I like this.  memcpy is not needed for the base struct indeed.

> 	memcpy(new_md->u.tun_info.options, md_dst->u.tun_info.options,
> 		md_dst->u.tun_info.options_len);

But I'd keep the accessor function for the options pointer here, since
we have it, i.e. ip_tunnel_info_opts(&new_md->u.tun_info).

I'll run some tests with that and post a patch.

> 
> Is this the only place in the kernel where a struct ip_tunnel_info is
> being copied? The above really looks like an open-coded helper. :)

On a quick look through the code, it seems like this is the only place
where the data is copied directly from one tun_info into another.
Other places either construct the structure to/from other places or apply
modifications.  And so the ip_tunnel_info_opts_set() is suitable in those
cases, but not in here.

Best regards, Ilya Maximets.

