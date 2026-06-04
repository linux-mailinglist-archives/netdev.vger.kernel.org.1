Return-Path: <netdev+bounces-295001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y6hrEJPTIGr48AAAu9opvQ
	(envelope-from <netdev+bounces-295001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 03:23:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C19863C2F8
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 03:23:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=sv6Bvs7n;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295001-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295001-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10CD8300D362
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 01:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4E42441A6;
	Thu,  4 Jun 2026 01:23:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA9F1F3BA2
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 01:23:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780536207; cv=none; b=qdVzxtnA1UQFBU/2apDsKL8tw4/veFjRUTNhmqEqd3q41JsRItApFntFWOogiuLPR754Kv1QAbAvJ5Qa7CQDPl7dGdfS7tH3WL0cBhI/vdhHY9NC87HRjQwlKTvw4HyUT2YAHw+gzEBFVt4jctT1xZAvLIx2EI3Ljd/n5e3WmOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780536207; c=relaxed/simple;
	bh=/uexet64WkJkeoILGHPeDkPYub+Dt/qN9RMWAta+5lk=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=UWvn96TMVC5uZQgX+2ERw3DD7s6qzSWDNBfCN4gvYtJ4wERpWtNRh/VaAszbtfAIgHScGTdPu5RuExFVBtrL/swDfg8eggwZiYEX4r8RWH4kVwskGABB/2GQ5v5hYdSPZycJhbRQVh8egZ+ZqzoxvhI9+Moa8bzQpptJbfmyb2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=sv6Bvs7n; arc=none smtp.client-ip=74.125.224.46
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6607e80a846so236722d50.2
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 18:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780536204; x=1781141004; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0BPiQqQWOCvLDyFVNh7cc+MJl54bmU+Ayz1shZYw+E=;
        b=sv6Bvs7nZWFgkTI8h2urjU8DhnsA58t0+WvH5EwVKhRFWBZIsSc00SMmzrpN/LQYkD
         VvSM4+PU5CB1p/YyC+7C1wNlYfYT3BtQTbAmbIPXbolHGdLLsTi2X3+WhSYeJuRkqTxu
         AgCRoxBRCgnae2FrZltspYZh+/LcqRVXMNEJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780536204; x=1781141004;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i0BPiQqQWOCvLDyFVNh7cc+MJl54bmU+Ayz1shZYw+E=;
        b=sGF+LlPK7cSlpX7Ik8jdWrS8d55NI/Kkvu7Gox2oB8CEkDXuPty+HihTkpB3rUio9h
         nLy10ssZU7HM5ZpjsASNav9rx3FavYyhVXRjMYg6xSqLLPzfDvVbu0+h1OJGzFWUtod1
         UsATV3AzaGzen7oCN0G7aYP6hIqTfXTPcky1cklE0iamfRrkFMEZ14kd52taUSkMNqzM
         d98/V7nd7Vh/DZFuUI+i2WnzBtwJoJ4DOM3cQ5uCXCmjvEfVGzOzguHILlOpZcMM9ILE
         HvdwKqyLxBOkPJd8BivsTTQClTAUL+MzXBfezqIB8gjNU8bLN5Whx24YGi8lC9OEJK4H
         nkxw==
X-Gm-Message-State: AOJu0Yx1Wt/Z6sbARxKKOp76cHVo5yubytYaLe0+y75RwdMapVJBCxKz
	681cj9e1ac38p3X2V9aZRfNS/XpNkZXN5RWtaurHrJ+s8p5DgrsVdQR1+5lybwJ8oQ==
X-Gm-Gg: Acq92OGX5LDrS4mGw40XKD2AfS6pfjESDYPbynucDyqdRzridk+UjQ2vAGfMwJm4PhZ
	oA0RdGMFh2cZVdrn6KbwL+CiyhOpJ9yamA0EGsGK00tn7Bm9/isMfLfrCqMRFIdV9c+Dj3pM37i
	teL8nordQrnNNnRB9fa4592Z6T8+kLAUywgumoKbIAVRDGBqpQw2HdKng66J7lEM6xID5iIXWUU
	CPw8jazqsIqVk4U2jNrevNrNHxV5BEGFcLHGM4jFumR9+f2RB8HRpfv+voC8UQwr7pwpy9sZ699
	F0b2Df+IuYU4AruqftysSWiKWGWDKJEV4PF5+znrlo39dYV/8usX9IGvmRw+Zi42bmLnqVbo7d/
	KuyzqRE6l5eyYklJaZKhHHm/MWFl+QGPhLW0XTzYgjbaMOQY0DO0w8a+cP2TyCHa5/F6Dxh6Zxb
	r/Wv9RIE8RV3Pxy+g57HqfoVwXlajB9yk1mv9Ujg2P6cIfjRTbw3jL4CdDAxRSRJ0tNXJTrWGUv
	uk0
X-Received: by 2002:a05:690e:134f:b0:65e:48cd:7fd2 with SMTP id 956f58d0204a3-660dc5617b5mr5309790d50.54.1780536204443;
        Wed, 03 Jun 2026 18:23:24 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c54:4d67:f17:d82a:d5b8:20a? ([2804:14d:5c54:4d67:f17:d82a:d5b8:20a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d647d3aesm2917077d50.18.2026.06.03.18.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 18:23:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------TElK26D2e6Hp9SoCOZztwLeW"
Message-ID: <8978c158-b005-4b53-99d7-b475d9c4c665@mojatatu.com>
Date: Wed, 3 Jun 2026 22:23:20 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] net/sched: HFSC + fq_codel stall on 6.6.116
 (qdisc_tree_reduce_backlog / qlen_notify)
To: Anirudh Gupta <anirudhrudr@gmail.com>,
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
 "jhs@mojatatu.com" <jhs@mojatatu.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Anirudh Gupta <Anirudh.gupta@sophos.com>
References: <CAN2cbVe79oj0O9==m4+4x3v+O+qzRagA=2=wkrp9i9=CqYvyZA@mail.gmail.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <CAN2cbVe79oj0O9==m4+4x3v+O+qzRagA=2=wkrp9i9=CqYvyZA@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anirudhrudr@gmail.com,m:xiyou.wangcong@gmail.com,m:jhs@mojatatu.com,m:netdev@vger.kernel.org,m:Anirudh.gupta@sophos.com,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,mojatatu.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295001-lists,netdev=lfdr.de];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mojatatu.com:mid,mojatatu.com:from_mime,mojatatu.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C19863C2F8

This is a multi-part message in MIME format.
--------------TElK26D2e6Hp9SoCOZztwLeW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi

On 02/06/2026 16:12, Anirudh Gupta wrote:
> Linux 6.6.116 can permanently stall traffic under this qdisc tree on ifb0:
>           HTB → prio → HFSC (class 1:a, RT 320Kbit) → fq_codel
> 
> Symptom:
>    tc -s shows hfsc/fq_codel backlog stucks while Sent byte/packet
> counters do not increase for 30+ seconds. No kernel oops.
> 
> Steps to reproduce:
> 1) Use attached script ‘apply_tc_tree.sh’ to create the required tc qdisc tree.
> 2) Send bulk short lived tcp connections, on the interface whose
> traffic is mirred to ifb0 interface for rate limiting.
> 3) Observe that the sent bytes in class statistics get stuck, while
> the backlog counter keeps on increasing -
> [...]

Can you check whether the attached patch fixes the bug?

cheers,
Victor
--------------TElK26D2e6Hp9SoCOZztwLeW
Content-Type: text/x-patch; charset=UTF-8; name="hfsc_anirudh_fix.patch"
Content-Disposition: attachment; filename="hfsc_anirudh_fix.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL25ldC9zY2hlZC9zY2hfZnFfY29kZWwuYyBiL25ldC9zY2hlZC9zY2hf
ZnFfY29kZWwuYwppbmRleCAyNGRiNTQ2ODRlOGEuLjlhZWJmMjVkZGM3OSAxMDA2NDQKLS0t
IGEvbmV0L3NjaGVkL3NjaF9mcV9jb2RlbC5jCisrKyBiL25ldC9zY2hlZC9zY2hfZnFfY29k
ZWwuYwpAQCAtMjgwLDcgKzI4MCw3IEBAIHN0YXRpYyB2b2lkIGRyb3BfZnVuYyhzdHJ1Y3Qg
c2tfYnVmZiAqc2tiLCB2b2lkICpjdHgpCiAJcWRpc2NfcXN0YXRzX2Ryb3Aoc2NoKTsKIH0K
IAotc3RhdGljIHN0cnVjdCBza19idWZmICpmcV9jb2RlbF9kZXF1ZXVlKHN0cnVjdCBRZGlz
YyAqc2NoKQorc3RhdGljIHN0cnVjdCBza19idWZmICpfX2ZxX2NvZGVsX2RlcXVldWUoc3Ry
dWN0IFFkaXNjICpzY2gpCiB7CiAJc3RydWN0IGZxX2NvZGVsX3NjaGVkX2RhdGEgKnEgPSBx
ZGlzY19wcml2KHNjaCk7CiAJc3RydWN0IHNrX2J1ZmYgKnNrYjsKQEAgLTMxNywxMiArMzE3
LDQ5IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqZnFfY29kZWxfZGVxdWV1ZShzdHJ1Y3Qg
UWRpc2MgKnNjaCkKIAlxZGlzY19ic3RhdHNfdXBkYXRlKHNjaCwgc2tiKTsKIAlXUklURV9P
TkNFKGZsb3ctPmRlZmljaXQsIGZsb3ctPmRlZmljaXQgLSBxZGlzY19wa3RfbGVuKHNrYikp
OwogCisJcmV0dXJuIHNrYjsKK30KKworc3RhdGljIHZvaWQgZnFfY29kZWxfZGVxdWV1ZV9k
cm9wKHN0cnVjdCBRZGlzYyAqc2NoKQoreworCXN0cnVjdCBmcV9jb2RlbF9zY2hlZF9kYXRh
ICpxID0gcWRpc2NfcHJpdihzY2gpOworCiAJaWYgKHEtPmNzdGF0cy5kcm9wX2NvdW50KSB7
CiAJCXFkaXNjX3RyZWVfcmVkdWNlX2JhY2tsb2coc2NoLCBxLT5jc3RhdHMuZHJvcF9jb3Vu
dCwKIAkJCQkJICBxLT5jc3RhdHMuZHJvcF9sZW4pOwogCQlxLT5jc3RhdHMuZHJvcF9jb3Vu
dCA9IDA7CiAJCXEtPmNzdGF0cy5kcm9wX2xlbiA9IDA7CiAJfQorfQorCitzdGF0aWMgc3Ry
dWN0IHNrX2J1ZmYgKmZxX2NvZGVsX2RlcXVldWUoc3RydWN0IFFkaXNjICpzY2gpCit7CisJ
c3RydWN0IHNrX2J1ZmYgKnNrYjsKKworCXNrYiA9ICBfX2ZxX2NvZGVsX2RlcXVldWUoc2No
KTsKKworCWZxX2NvZGVsX2RlcXVldWVfZHJvcChzY2gpOworCisJcmV0dXJuIHNrYjsKK30K
Kworc3RhdGljIHN0cnVjdCBza19idWZmICpmcV9jb2RlbF9wZWVrKHN0cnVjdCBRZGlzYyAq
c2NoKQoreworCXN0cnVjdCBza19idWZmICpza2IgPSBza2JfcGVlaygmc2NoLT5nc29fc2ti
KTsKKworCWlmICghc2tiKSB7CisJCXNrYiA9IF9fZnFfY29kZWxfZGVxdWV1ZShzY2gpOwor
CisJCWlmIChza2IpIHsKKwkJCV9fc2tiX3F1ZXVlX2hlYWQoJnNjaC0+Z3NvX3NrYiwgc2ti
KTsKKwkJCS8qIGl0J3Mgc3RpbGwgcGFydCBvZiB0aGUgcXVldWUgKi8KKwkJCXFkaXNjX3Fz
dGF0c19iYWNrbG9nX2luYyhzY2gsIHNrYik7CisJCQlzY2gtPnEucWxlbisrOworCQl9CisK
KwkJZnFfY29kZWxfZGVxdWV1ZV9kcm9wKHNjaCk7CisJfQorCiAJcmV0dXJuIHNrYjsKIH0K
IApAQCAtNzI1LDcgKzc2Miw3IEBAIHN0YXRpYyBzdHJ1Y3QgUWRpc2Nfb3BzIGZxX2NvZGVs
X3FkaXNjX29wcyBfX3JlYWRfbW9zdGx5ID0gewogCS5wcml2X3NpemUJPQlzaXplb2Yoc3Ry
dWN0IGZxX2NvZGVsX3NjaGVkX2RhdGEpLAogCS5lbnF1ZXVlCT0JZnFfY29kZWxfZW5xdWV1
ZSwKIAkuZGVxdWV1ZQk9CWZxX2NvZGVsX2RlcXVldWUsCi0JLnBlZWsJCT0JcWRpc2NfcGVl
a19kZXF1ZXVlZCwKKwkucGVlawkJPQlmcV9jb2RlbF9wZWVrLAogCS5pbml0CQk9CWZxX2Nv
ZGVsX2luaXQsCiAJLnJlc2V0CQk9CWZxX2NvZGVsX3Jlc2V0LAogCS5kZXN0cm95CT0JZnFf
Y29kZWxfZGVzdHJveSwK

--------------TElK26D2e6Hp9SoCOZztwLeW--

