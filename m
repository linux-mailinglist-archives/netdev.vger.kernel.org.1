Return-Path: <netdev+bounces-281793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIuwLoeW8GmrVQEAu9opvQ
	(envelope-from <netdev+bounces-281793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:14:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1851C48372C
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A42B307616A
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD433FE375;
	Tue, 28 Apr 2026 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxzCde/1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nq1v2QjW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B52A3F7A9C
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777373641; cv=none; b=PI/+QTDvyKEQD7NtnLWrNV4tpzxVigSypk99QPeZ4Oj2iaMSHj53+QLjLY9qKbpeCg9v7yuLOcrIdjfy2OQwr/dyn9BcSmizUIWSxkxbNvI0CdRZGbPoaRa2fScX96MzJpAOH7Rgt7G7Thg4ONLjwIq9L+BXHBfI5lTDqf28nyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777373641; c=relaxed/simple;
	bh=Neiif6SXKuMFt4fSvxvfwPE0O1nufotAa9lDBnwDc1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKNSjml9HsV80G2YQjXk5ZgdjM6LOvSQRgCZIpicJ3cfDqqty6osx54Ip1ol8ti6Ka2JsRsCeIOyegYi68dPFtd+nJrQItfoe1AjRwL3htiAr43ACi1F6O0JcT/0dV4qZ31+ffEO5KshIRaN3QSPUVeUGV97uE8/h32E3fvbl9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NxzCde/1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nq1v2QjW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777373639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+wO2zZc1v2D2ebLfOKlbKe3iVht2fKPYi3hJNxw/Jks=;
	b=NxzCde/1a/UETR2RB7+1XGpYxmrDLogxdbyB2z3JWdVx/GGDzgo5irjYG4cQTTb2YoPEox
	G96SIvj3eM+U3avDe3gH5uOHrIKMmw+XVNgsPAXnrGYTEh2n8SHV0Zpxv6SRE45cSbDQdi
	jOJQQC+IHxjH0C/K+mhW3xRLih0eaEc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-w_Ybq8_eO2qCFy7xIsGnwQ-1; Tue, 28 Apr 2026 06:53:58 -0400
X-MC-Unique: w_Ybq8_eO2qCFy7xIsGnwQ-1
X-Mimecast-MFC-AGG-ID: w_Ybq8_eO2qCFy7xIsGnwQ_1777373637
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8ed2c173d3bso1823810985a.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 03:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777373635; x=1777978435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+wO2zZc1v2D2ebLfOKlbKe3iVht2fKPYi3hJNxw/Jks=;
        b=nq1v2QjWnK0z+EmOMU19/KSyYA4fNOiq40mHiceZNvb3hEhm0tiIi4RJ/Yu9+U41fW
         GVi4Zq81KvaDGnwLlSDIgIM6bffohu6SwNYN9UUCRKXcu2apWtcnw0SZrIaEjuvDZuH0
         vbd6wCxn5E2hRfbNhsuy8tcUNuE6r+3qxhwEQT7Q8IUxfkD4v/uBrdxtm5oUnstXtY46
         qR3RPp2tiNLxe9AmH7mWTs5FkKGvAREESc7YJnz6e6hemEuCh52twk83urvrvCVNqEdH
         ApCnafoh6jHLbs4KbxpkdoNWwkWRpJeOiXUCLSn0WP/dpUmqrY5BG/aPHVflef9bcdKy
         1QxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777373635; x=1777978435;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wO2zZc1v2D2ebLfOKlbKe3iVht2fKPYi3hJNxw/Jks=;
        b=gRMHDQxQXdb4wMdXRHNg7710BcSllewST4sgaD6WuJsomKRQ0EiTSm4qrq5XGuNr9m
         9ZXzQ8NCMc8QHP5FtyTlGKReEifciY9nzsbc4/7NAfibk7G3MZK6jAnQ/92SvVSN+7OR
         c+A67Ve4uYE5VipNTUBfdfGVtOyxiBCPz29pABrzzSoeRfALLZ7rOVlqLruOtQZk8ZIk
         Rud8VcCZFY7tcXjmPr4ONCq9q0WHn3SdriLVOI5fayEmP95jsRL4avFlKZS3Oen4pvHB
         wyRDhpPqbTZi8Pdrv44HdwR50HNMMJlJuYnobiPnVgE1Z9af/La+DXTIMxcMfFSRtxE8
         stZw==
X-Gm-Message-State: AOJu0YyMjnlWqCZao8WZD8IaPRtw0Gln74HsOz1uSrDZZiWc3y86xkP+
	IeoZTX3bxJq7JkeWc0Onm7E9gTjyopktUpMoQdcGZtROQn1UDOQKWJ5v6E5kEs21RSd7Cqcr3J+
	zUqmAfrQ8nSl96htKDSyP+t+WVWLRJ7EwQfl2DLC9rIjwt8kEXyof5pzfrXkExYBgJhMl
X-Gm-Gg: AeBDieu9FRiqtDXlAQvMHn6RXyIdI32wNpAc3xP/PcRXGO4A6s/8mJfxvKgEG9a2E44
	Gm1uyIjVEfLu2nHhoLICaIL+RokQ5l+Ld98pg+oREdJbZD8vH5ZN9kzT1tIyiHK8VStCsF2wGwk
	96w6bav8yqwcZCoVZu+NS17ruUMHKZtlGc58VsheKEDsAT0M7wpepOZdW6+5GDEfpjbSbIaN4sB
	w5hb5cP++2k5zUzTKZzSOwiRY7wG4zcNUtywe9Xh/E8mWCAKO7HRNKqNsYF4zbTNf9TW5c5ViOp
	pBFtNdP3hDf6Cfz7CijJxcl8GoBu6i8iZu1g6bJbfVu/RL5VwbZOzsE3+moDc0z/bFNwk/gDatg
	IjI4eZvOLTYC6b71x6fE=
X-Received: by 2002:a05:620a:bd3:b0:8ee:bae8:2bb8 with SMTP id af79cd13be357-8f7d920261emr295662185a.36.1777373635112;
        Tue, 28 Apr 2026 03:53:55 -0700 (PDT)
X-Received: by 2002:a05:620a:bd3:b0:8ee:bae8:2bb8 with SMTP id af79cd13be357-8f7d920261emr295658485a.36.1777373634541;
        Tue, 28 Apr 2026 03:53:54 -0700 (PDT)
Received: from [10.43.3.161] ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c7cd2becsm161540785a.29.2026.04.28.03.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 03:53:53 -0700 (PDT)
Message-ID: <c90116ad-4b32-4a55-970c-fd8518fccf62@redhat.com>
Date: Tue, 28 Apr 2026 12:53:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 0/4] iavf: fix VLAN filter state machine races
To: Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Mitch Williams <mitch.a.williams@intel.com>,
 Aaron Brown <aaron.f.brown@intel.com>,
 Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <cover.1776426683.git.poros@redhat.com>
 <20260421090254.GW280379@horms.kernel.org>
 <b2d56951-4776-4d99-bb4a-69ef7da0a502@intel.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <b2d56951-4776-4d99-bb4a-69ef7da0a502@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1851C48372C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281793-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]


On 4/23/26 22:48, Jacob Keller wrote:
> On 4/21/2026 2:02 AM, Simon Horman wrote:
>> On Fri, Apr 17, 2026 at 04:29:41PM +0200, Petr Oros wrote:
>>> The iavf VLAN filter state machine has several design issues that lead
>>> to race conditions between userspace add/del calls and the watchdog
>>> task's virtchnl processing.  Filters can get lost or leak HW resources,
>>> especially during interface down/up cycles and namespace moves.
>> ...
>>
>> Hi Petr,
>>
>> Sashiko has a bit to say about this patch.
>> I'd appreciate it if you could look over that.
>>
>> In particular, the feedback on patches 2 and 3 may warrant
>> some updates to this patchset, while I think 4 is more
>> in the realm of possible future work.
> @Petr,
>
> Could you please review the Sashiko reports and clarify whether a new
> version will be needed?
>
> The original series posted as a net-next was Tested-by, and it would be
> good to get this moving, but I don't want to queue it up for sending
> until certain it won't simply get rejected due to these unresolved comments.
>
> Thanks,
> Jake
>
Hi Jake,

The Sashiko review identified seven concerns across the four patches.

Five of them describe sub millisecond race windows. Rapid del and re add
of a VLAN in IAVF_VLAN_ADDING state. Pending IAVF_VLAN_ADD lost across
down and up before the watchdog ships the request. REMOVING combined with
user re add and user re del state confusion. The reset path resurrecting
filters that are in REMOVE or REMOVING state. Phantom ACTIVE after the PF
rejects an ADD whose user side del raced through.

The remaining two are deterministic pre existing V1 bugs unrelated to
this series. The V1 ADD_VLAN error path has never called 
iavf_vlan_add_reject().
The V2 path got it in 968996c070ef ("iavf: Fix VLAN_V2 addition/rejection")
and V1 was missed. These manifest whenever the PF rejects an ADD on i40e
for example a port VLAN conflict or an untrusted cap reached, and they
belong in a separate fix.

The five race window findings require tight syscall sequencing via ip batch
or sysfs FLR concurrent with del to reach. These patterns do not match how
NetworkManager, systemd-networkd, libvirt or cloud-init configure VLANs.
Those tools add VLANs once on VF setup and do not issue rapid del and
re add or trigger FLR mid operation. The current version keeps the state
machine minimal. Closing these windows requires per filter flag tracking
that adds complexity disproportionate to the user visible benefit on real
workloads.

Two larger problems are worth addressing in follow up work.
The first is num_vlan_filters accounting on V2 under high churn.
Post series, filters in REMOVING state count against
iavf_get_max_vlans_allowed until the PF confirms the deletion.
This can cause a transient EIO on rapid del then add when at the cap.
Pre series this was avoided by immediate kfree. The trade off here is
correctness (no HW resource leak on PF reject) at the cost of a transient
userspace error.

The second is the i40e silent ADD reject. The i40e PF rejects over cap or
untrusted VF VLAN ADDs by returning VIRTCHNL_STATUS_SUCCESS, so iavf cannot
surface the failure to userspace. ip link add ... type vlan reports success
while no filter exists in HW. V2 on ice avoids this via the client side cap.
Closing this gap requires PF and driver ABI coordination.

The series has been tested across documented user workflows on both
ice and i40e PFs in trusted and untrusted modes. The tested scenarios
include interface up and down cycles, namespace migration, VF reset,
VLAN add and remove sequences, parallel VLAN operations across two VFs,
traffic verification via ping under spoofcheck, port VLAN, and multi
VLAN configurations. The workflow scenarios pass on the patched kernel.

The small number of test failures observed were test framework artifacts
(missing IP configuration on probe interfaces, settle time too short for
PF round trip drainage, V1 PF reject classification) and not kernel 
regressions.

Regards,

Petr


