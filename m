Return-Path: <netdev+bounces-290573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKifCNhFD2ptIgYAu9opvQ
	(envelope-from <netdev+bounces-290573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:50:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D4A5AA962
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 850FB302F5AA
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0A13EA95C;
	Thu, 21 May 2026 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIz0M6Hs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0C03EC2DD
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779385435; cv=none; b=uMgj7NYt9B8Z4CTPEevKYmV/KAfoobnCw7XMZPQ627El8/zXUdvyqy5yZ4u1352UylwzmxCtMkC8xd9P5fz93WqCrgk8ZBnK9pMwI/A85SuRjqvL5uPKNOxTmtktB0AWfdsRa4O+jsh5y89Djy6Yo6JqfWvfCRhl7D9WrjxsV8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779385435; c=relaxed/simple;
	bh=7Vm+/QWiN+XdxVzyl3UbUUWYGslG5rkNMIa3xfTjx4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7wOg+w+DjJ+Tefmm4qK7kp47mwjFZgSeu76ZrIZgR0lS4nYEoo1+VJtBKlvqZEt/9hIlEt6vjXHNyJ5MDos36YcdV3VyFMxfcvmuXof/VRRLjPYEwq6kx2HhFYsFS0j2p0owysxaXHPDxSwUkNcnvZyrl0UcaWrirl5euPq8rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIz0M6Hs; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1357c851a48so7663247c88.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 10:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779385429; x=1779990229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IK6KJJ4n+vGIyBwX19FWSPbqjF3YQMXQ6RtoXPQ6tzM=;
        b=CIz0M6HsM25FpJd6zOpjbpZ06kT3T9hy1ibSXnLO8rYgmcszaM2E15EJhqhZaCZhWF
         dEQi50pwwO4+s2OQ9923ft8INZRi/KkFY5Z1BY0gG5QlivPjXRz0W1/EKRSBBQfU0siB
         n0zZdXnMpSpj4MFW2CHvvtWzLiiNNu93GiTIGIzKdaxoK/uwjQ43VnLwrP6XpNhLHt91
         rM8UJgXNfekdKPx+v0D3AwXpPWDeFy20VA0BZVsE55lHOh2Ez6ZXQaoMCa2EBNJK3rb7
         hn0vql8jTkznjOLlScrdxpMgDFivybmnSbBQKSkYDa1DuFYoqkl51EH6eVNvhfS2owGD
         uU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779385429; x=1779990229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IK6KJJ4n+vGIyBwX19FWSPbqjF3YQMXQ6RtoXPQ6tzM=;
        b=Ht4LHqiV/fJCinICl6toZYzRdAVBjkFvsLwTbXMs+8C8+hY+8/qjiby/cYqcEIHIvv
         Fi7HwJ+XZaiFN2b51j4G1XGym8RuVzeQLBTWpxHfe6VPlSGUG2xlNmG8atZMnGkIyv3y
         4uuvnIDLXdlzz3N13Ij/qCYjue6vMJxgNAmQPhCFxXYLpFtKAUx3+7FRIS7M4nlS/yim
         4jl3m46jajyLTKCj7LwWjEsvI480iD6eR0yjtPg+EBW6MTc4MFxz948QuJwEZjbY7TLw
         PNPQKZS/W+DqcaXe5/m+nt9swbUQjj6aZU466rrB/8p/16G7QbxR1EBBI2MsN4tfNNqC
         X0TA==
X-Forwarded-Encrypted: i=1; AFNElJ+TJAPo+C426JKpMkV+EwLv8dC0m0XNH+w8boe2b71kn78c9wU1Q0DJcHvDmY7AjNbziLiVz3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9KD59ysnRH7q9oAaivMJkK81g24egL8xZMkOYhcDs1rpLKokx
	YLreW9ao3tBuTZCrpbFVWC2mDXog5Y3JK7dyOY+2aMlHtvSjSUx43OiJ
X-Gm-Gg: Acq92OFRihBJEjiDJrs7gQsSAprNXQDVe9Hl8j0+ODSZfUkeY7Aa9IvBbIb7W9BsXJ3
	Z+hmAZtPBwv3EKw8YYNb7ODYXXl5c2C3GNer+JczFANe4ySSfLn6uJM5kSQPtofceMV0QkirnLH
	cnQh7uwtwC6Dc3J1yiUa1uu4ry8bg1WKIR0dnScMMYbewiy1DH5vsKVyhYEA+27N0veiUE0VXg6
	5ywbgtDr+PA0o/TqtisYjG8X4siNiPUQ5pNKu9s6bb1HF+d/C9bvDkyqZ3LTDwtyL41aIuTygjv
	uZEU6ItcQ1oQzrxDp7Er9yg3/d4dZ0C6yaaeFTC8QX3dXvWd0HjtJTOiT7JqbUXaPoGPi72P7iY
	MhBAyGob8Iud2tNuYkyfnZVNyOa5Bkeoa/2uTs2w2GNDQSxZK//dMkDf026Pxine5q/BQOepBQT
	fZ+hFgV9KDT4rLul5/4ZHmS5gaZhCyQcvIaiJHzXX1iJ4o9kMnAislzhpQdtQ=
X-Received: by 2002:a05:693c:2c8e:b0:2ed:f791:3417 with SMTP id 5a478bee46e88-3044912c0ecmr66091eec.25.1779385429270;
        Thu, 21 May 2026 10:43:49 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21cf::14a4? ([2620:10d:c090:400::5:6ef])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30443577a8bsm970134eec.15.2026.05.21.10.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 10:43:48 -0700 (PDT)
Message-ID: <fd6fa33c-5ff1-4c6b-9f06-6744bf44ba9a@gmail.com>
Date: Thu, 21 May 2026 22:43:41 +0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [iproute2-next V4 0/6] netshaper: Extend netshaper support
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: alexander.duyck@gmail.com, stephen@networkplumber.org, pabeni@redhat.com,
 kuba@kernel.org, ernis@linux.microsoft.com
References: <20260518202353.390827-1-mohsin.bashr@gmail.com>
 <88ec611d-53c1-447b-b236-67523532cfaa@kernel.org>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <88ec611d-53c1-447b-b236-67523532cfaa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,networkplumber.org,redhat.com,kernel.org,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290573-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 76D4A5AA962
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/19/26 6:10 PM, David Ahern wrote:
> On 5/18/26 2:23 PM, Mohsin Bashir wrote:
>> From: Mohsin Bashir <hmohsin@meta.com>
>>
>> This series extends the netshaper CLI with missing parameter support
>> and adds the group command for building scheduling hierarchies.
>>
>> The existing netshaper tool only supports setting bw-max on individual
>> shapers. This series adds the remaining shaper attributes (bw-min,
>> weight) needed for TX scheduling, and introduces the group command
>> which ties leaf shapers to a parent node in a single operation.
>>
>> Changelog:
>> V4:
>>    Patch 2:
>>    - Reorder BW_MAX/BW_MIN to BW_MIN/BW_MAX in usage text
>>
>>    Patch 5:
>>    - Extract parse_scope_id() to share handle/parent scope+id parsing
>>    - Extract parse_leaves() with dynamic allocation, removing the
>>      static NET_SHAPER_MAX_LEAVES limit
>>    - Add per-leaf weight and priority support in group command
>>    - Remove inline declarations
>>    - Skip parent nest when parent not specified
>>    - Use goto free_leaves for error cleanup
>>
>>    Patch 6:
>>    - Document per-leaf weight and priority usage
>>
>> V3: https://lore.kernel.org/netdev/20260511183915.797792-1-mohsin.bashr@gmail.com/
>> V2: https://lore.kernel.org/netdev/20260509022353.3470738-1-mohsin.bashr@gmail.com/
>> V1: https://lore.kernel.org/netdev/20260501011611.3533573-1-mohsin.bashr@gmail.com/
>>
>> Mohsin Bashir (6):
>>    netshaper: Extract parse_scope() and parse_rate() helpers
>>    netshaper: Add bw-min and weight parameter support
>>    netshaper: Extend show output with parent, bw-min and weight
>>    netshaper: Extract struct shaper_args and parse_shaper_arg() helper
>>    netshaper: Add group command for creating scheduling hierarchies
>>    netshaper: Update man page for new parameters and group command
>>
>>   include/utils.h       |   1 +
>>   man/man8/netshaper.8  | 150 ++++++++++--
>>   netshaper/netshaper.c | 554 +++++++++++++++++++++++++++++++++++-------
>>   3 files changed, 597 insertions(+), 108 deletions(-)
>>
> 
> Applied the set to iproute2-next.
> 
> With those patches applied, I asked Claude (model is Opus 4.7) "check
> man/man8/netshaper.8 for errors"; output below. Please send followup
> patches or address why current state is ok (ie., why claude is wrong).
> Thanks,
> 
> 
> ● I read the page and compared it against netshaper/netshaper.c. The
> page renders without man warnings, so the issues below are content /
> accuracy:
> 
>    Substantive issues
> 
>    1. Missing parent scope restriction. In the PARAMETERS description
> (man/man8/netshaper.8:188-198) parent is said to "use the same scope/id
> syntax as handle." But the code
>    (netshaper/netshaper.c:357-360, parse_scope_id()) rejects anything
> other than node or netdev. The man page never says that queue is invalid
> as a parent scope. The synopsis at
>    man/man8/netshaper.8:52-55 also uses an unrestricted PARENT_SCOPE token.
> 
>    2. Missing leaf scope restriction. parse_leaves() at
> netshaper/netshaper.c:416-420 rejects any leaf whose scope is not queue.
> The PARAMETERS section for leaves
>    (man/man8/netshaper.8:200-209) only implies this by example ("Each
> leaf is given as scope queue id ID") rather than stating the constraint.
> Worth saying it explicitly so the reader
>    doesn't think they can drop in a node leaf.
> 
>    3. Confusing "scheduling groups" wording on the node scope. Line
> 95-96: "Shapers representing scheduling groups that can be placed at
> arbitrary locations..." — group is also a
>    command name, so calling a node "a scheduling group" muddles the
> terminology. "Intermediate scheduling nodes" (matching tc-style
> language) would be clearer and matches what's said
>    two paragraphs later ("scheduling node shaper").
> 
>    4. show / delete synopsis shows id as optional for all scopes. Lines
> 36-42 give [ id HANDLE_ID ] for both commands, but the code requires id
> for queue and node scopes on every
>    command (netshaper.c:268-282, called from do_cmd() for SET/GET/DELETE
> alike). The description does spell this out under the scope list, but
> readers who only glance at the synopsis
>    will be misled. The set synopsis at line 26-27 has the same problem.
> 
>    5. -help synopsis is incomplete. main() strips a leading -
> (netshaper.c:608-609), so --help, --Version, --color all work too. The
> man page only documents the single-dash forms.
>    Minor — but inconsistent with what the binary accepts.
> 
> 
>    Style / formatting nits
> 
>    6. Bold/italic mixed on literal keywords in the synopsis. dev, handle,
> scope, and the scope values are bold; but bw-min, bw-max, weight, id,
> parent, leaves get italicized via .RI
>    (e.g. lines 26-33, 50-61). Convention in iproute2 man pages is bold
> for literal keywords. The page renders fine but the typography is
> inconsistent.
> 
>    7. { … } [ … ] for leaves is unusual (lines 62-64). Renders as leaves
> { scope queue id ID [ weight WEIGHT ] [ priority PRIO ] } [ ... ]. Curly
> braces normally denote a required
>    choice; here they're being used as repeat-group brackets. A plain
> comment in the description or leaves SPEC [ SPEC ... ] with SPEC defined
> separately would be clearer.
> 
>    8. .IR DEV etc. Single-argument uses of .IR / .BR (lines 23, 25, 27,
> 29, 31, 33, 38, 40, 42, …) are equivalent to .I / .B. Cosmetic.
> 
>    9. Date in .TH ("7 Oct 2025", line 1) hasn't been bumped despite later
> commits (e14b336, 2638fef) updating the man page.
> 
>    10. Example 4 wording is slightly ambiguous. "Creates a node shaper
> under the netdev parent with a 10 Gbit/s cap" — bw-max 10gbit applies to
> the node (handle), but a reader could
>    attach it to "netdev parent." Tightening to "…with a 10 Gbit/s cap on
> the node" would remove the ambiguity.
> 
>    The most worth-fixing items are #1, #2, #3, and #9.

Yeah, this definitely need a follow-up and I should have been more 
explicit instead of making assumptions in certain cases. Will send a 
follow-up patch on iproute2-next.


