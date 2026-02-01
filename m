Return-Path: <netdev+bounces-255595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TpAKCx5Mf2mcnQIAu9opvQ
	(envelope-from <netdev+bounces-255595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 13:50:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D7CC5EC6
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 13:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B7CA300D617
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 12:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53217329C49;
	Sun,  1 Feb 2026 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8ZnWAVb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2382EA73D
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769950233; cv=none; b=gX83yP5kkfy6rct8BIk2VRjopNiccYg94yHAnr6kxqwqYtP69yhoG4wZWsDuiiLGc2Gr/qGRu93DBX7ST3CYeQANr1/MqOP6c6y5Ce3FCANNkageNOmMRuPp9p/ioNOqQQuApJ296NGDGXfxhsM7LOwUi9ZAxDNhlqgyFQQfW5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769950233; c=relaxed/simple;
	bh=wU8iwOO+nCA8m5VaMrIwVMoYlWbKtZG3FqK0mQlzG6M=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=ZPte2qKL/ASD1/2fFSatSzyU/+9fyeZV0BZLjXtCiJq3aImReB4La9oB9CgA7n9JmcAA411YBhc6wHLMZ++Fv3iQnYtYLLdBSk7Duw4Cx8/WQDT+zFrynUIZ0ZTv3/MfjW3WsucDVIwd54OJCyiQ6PCwgijCzFWt35/Tj3mPPfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8ZnWAVb; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42fb6ce71c7so2958590f8f.1
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 04:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769950230; x=1770555030; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igM1QDdPgWGudXi6hEzXqNjnsT8cl1m2LiEme6whO44=;
        b=A8ZnWAVbuvr9QcWYRHbWBROWWhZpVcGsf8vBiaVFlT7XdzStDS08vfLVMT5iyoV3iI
         KjhqFxh85hLRGO9F54qu6bh9na/o3qmtzHk8gV3ifh8FwGPXjJ+C4QGVYPSGN6f53aYx
         P/D+lq5JaNfS/F3tk65d4daz7tKAg1DgB/W4yBLkGriIBu49RcxqZilDXlCaOzkhkZti
         Oeir0MdgWCN/xxXMZS0/YShxQJm5wCY7suotbeGLbk9ueSBFpGdLOrG7W3ZtV+pbLstm
         Ej3rGSoQ44qna7tJNypAewVyiSarTRBGsKCWcsDHpFkhJqTvXKKo8iCzXAJU3cv2r+K4
         D6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769950230; x=1770555030;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=igM1QDdPgWGudXi6hEzXqNjnsT8cl1m2LiEme6whO44=;
        b=L0/xLPj7vFDFSqIO6whSDfEqLWu2kJITxGrYx+NUQdTGBw2wXOW90iPwxaczqdHft9
         VAnxnHg8PmVG8lz+BB8ncaWvcJyTfA4WlqzA+sFYksbNSxgGi/TfjsWPf/FXZl7xad35
         kNEgCCKpssvA98UPZsx4T+Hx65XtEcYKj/cTMkCO87vWE36YltJHwUifiUaxDZuLfJpa
         akwOg56G/f2BXXRM3x7Fmdc3/RQ6owiyyjHvpZbpZ4gzP49L0+oU2A62f36hlYrcIcFQ
         hfuXAot23pdU4vCVSvnAdIV0wB3Qi3QXPrQay1cgwP0rzPwAVq2Uh8ENwtf5DyBQROyF
         ObJw==
X-Forwarded-Encrypted: i=1; AJvYcCUMNOSPtbC7x41ORMkTh8JmmZzQhbI2nq9fFqfV6icoM02659n8dbhhgRbdQGASODF9n0icH/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyhlOTN2ChWTJhm3g2xWY7v2M+2RwRI0l1vZ88tEWTGdLWrJ+J
	186gIea+ous1kXkJ7XRAewp6Z6uG5maTy17RmccR/t8PDW9g7RBexkwCP8pWQw==
X-Gm-Gg: AZuq6aI27v6ia/u3lNANOwLsHBTELulKDCpvjFXhKEQuzI13Oldnby+/A6It/wZsdMj
	nkQZiAv+dQ5oVstWZzqS1CDS2U2/5BGWB93uRJU1r6NGmzTU4rcoLU+j0qoqbQTy8F8paDeKjV7
	PSOhGEk8o74yqh0GBa7NYhciH5xQoEkqrusoj6/yGBMaAZEHxpkvtI5zMLaXtKImje2sOeL9XYp
	2wUCelLJF+glKyiu5F7MghyU5aV+SSdQ/9bqDdHKqtKi7A+5ntMd5YBm3eugEcGtUzrtsvkEx3O
	8gzUo6ICg/gG1RNdBvLhyRiMQQbFYWf2DbVmYyE7ug3XPS23O0SXRj1NB+CwYiu8Iu/uhvBoGt0
	pUjpThY4su3W5GKE1n9xQYHqMtcXcik/FP/DBSZ1PDN3sVJUCw2/JmBXbzoEPYpmwoIZ62+z7n0
	4pPIwH+e76svzdVKiqa9kKe1VM1MxX12BVvp0=
X-Received: by 2002:a05:6000:615:b0:430:f437:5a6d with SMTP id ffacd0b85a97d-435f3a7bc30mr11648177f8f.22.1769950229637;
        Sun, 01 Feb 2026 04:50:29 -0800 (PST)
Received: from [10.221.207.115] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1354205sm36739831f8f.41.2026.02.01.04.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 04:50:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------GyTieBIItEzAwqNhB00HJ7GN"
Message-ID: <421d9b09-a157-4f95-8775-7883ea097038@gmail.com>
Date: Sun, 1 Feb 2026 14:50:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: Undo saving per-channel async ICOSQ
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: William Tu <witu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 David Wei <dw@davidwei.uk>, Jakub Kicinski <kuba@kernel.org>,
 Gal Pressman <gal@nvidia.com>
References: <20260123223916.361295-1-daniel@iogearbox.net>
 <85776531-d5fa-4762-90aa-74c8397dc09b@gmail.com>
 <6188b9f5-ce38-4de9-80b7-c7b1cab48595@iogearbox.net>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <6188b9f5-ce38-4de9-80b7-c7b1cab48595@iogearbox.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255595-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90D7CC5EC6
X-Rspamd-Action: no action

This is a multi-part message in MIME format.
--------------GyTieBIItEzAwqNhB00HJ7GN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26/01/2026 11:23, Daniel Borkmann wrote:
> Hi Tariq,
> 
> On 1/25/26 9:33 AM, Tariq Toukan wrote:
>> On 24/01/2026 0:39, Daniel Borkmann wrote:
>>> This reverts the following commits:
>>>
>>>    - ea945f4f3991 ("net/mlx5e: Move async ICOSQ lock into ICOSQ struct")
>>>    - 56aca3e0f730 ("net/mlx5e: Use regular ICOSQ for triggering NAPI")
>>>    - 1b080bd74840 ("net/mlx5e: Move async ICOSQ to dynamic allocation")
>>>    - abed42f9cd80 ("net/mlx5e: Conditionally create async ICOSQ")
>>>
>>> There are a couple of regressions on the xsk side I ran into:
>>>
>>> Commit 56aca3e0f730 triggers an illegal synchronize_rcu() in an RCU 
>>> read-
>>> side critical section via mlx5e_xsk_wakeup() -> 
>>> mlx5e_trigger_napi_icosq()
>>> -> synchronize_net(). The stack holds RCU read-lock in xsk_poll().
>>>
>>> Additionally, this also hits a NULL pointer dereference in 
>>> mlx5e_xsk_wakeup():
>>>
>>>    [  103.963735] BUG: kernel NULL pointer dereference, address: 
>>> 0000000000000240
>>>    [  103.963743] #PF: supervisor read access in kernel mode
>>>    [  103.963746] #PF: error_code(0x0000) - not-present page
>>>    [  103.963749] PGD 0 P4D 0
>>>    [  103.963752] Oops: Oops: 0000 [#1] SMP
>>>    [  103.963756] CPU: 0 UID: 0 PID: 2255 Comm: qemu-system-x86 Not 
>>> tainted 6.19.0-rc5+ #229 PREEMPT(none)
>>>    [  103.963761] Hardware name: [...]
>>>    [  103.963765] RIP: 0010:mlx5e_xsk_wakeup+0x53/0x90 [mlx5_core]
>>>
>>> What happens is that c->async_icosq is NULL when in mlx5e_xsk_wakeup()
>>> and therefore access to c->async_icosq->state triggers it. (On the NIC
>>> there is an XDP program installed by the control plane where traffic
>>> gets redirected into an xsk map - there was no xsk pool set up yet.
>>> At some later time a xsk pool is set up and the related xsk socket is
>>> added to the xsk map of the XDP program.)
>>
>> Thanks for your report.
>>
>>> Reverting the series fixes the problems again.
>>
>> Revert is too aggressive here. A fix is preferable.
>> We're investigating the issue in order to fix it.
>> We'll update.
> Ok, sounds good. Certainly the kTLS fixes seem independent, from the cause
> of the issues I've hit it just seemed to me that they were quite 
> fundamental
> and that perhaps a different approach would be needed (or alternatively 
> only
> kTLS would need fixing, and the xsk optimization left as it was 
> originally).
> Anyway, I'll keep the revert locally for now, and happy to test patches.

Hi Daniel,

Please check attached patch.
We were able to repro the issues internally and verify the fix.
We're finalizing it before submission.

I'd be glad if you can confirm it solves the issues for you.

Thanks,
Tariq

--------------GyTieBIItEzAwqNhB00HJ7GN
Content-Type: text/plain; charset=UTF-8;
 name="0001-net-mlx5e-XSK-Fix-unintended-ICOSQ-change.patch"
Content-Disposition: attachment;
 filename="0001-net-mlx5e-XSK-Fix-unintended-ICOSQ-change.patch"
Content-Transfer-Encoding: base64

RnJvbSBmZDUxOTU4YWQwODM1Mjg4NTlhMTcxYTg0YWViYTcwMjE5ODk4NzJiIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUYXJpcSBUb3VrYW4gPHRhcmlxdEBudmlkaWEuY29t
PgpEYXRlOiBNb24sIDI2IEphbiAyMDI2IDE3OjA3OjI5ICswMjAwClN1YmplY3Q6IFtQQVRD
SF0gbmV0L21seDVlOiBYU0ssIEZpeCB1bmludGVuZGVkIElDT1NRIGNoYW5nZQoKQ2hhbmdl
LUlkOiBJZmZhYTE4M2Y5ZWQ4YTkxOTBjMzhiZTJjNTI5MGI0NGJmNmVmNzMxYQpTaWduZWQt
b2ZmLWJ5OiBUYXJpcSBUb3VrYW4gPHRhcmlxdEBudmlkaWEuY29tPgotLS0KIGRyaXZlcnMv
bmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9lbi5oICB8ICAxICsKIC4uLi9ldGhl
cm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW4veHNrL3Bvb2wuYyB8ICA0ICstLQogLi4uL2V0
aGVybmV0L21lbGxhbm94L21seDUvY29yZS9lbi94c2svdHguYyAgIHwgIDIgKy0KIC4uLi9u
ZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX21haW4uYyB8IDI4ICsrKysrKysr
KysrKysrLS0tLS0KIDQgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMTAgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gv
bWx4NS9jb3JlL2VuLmggYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2Nv
cmUvZW4uaAppbmRleCAxOWI5NjgzZjQ2MjIuLjYzZGE5ZjY4MGU4NyAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuLmgKKysrIGIvZHJp
dmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuLmgKQEAgLTExMDksNiAr
MTEwOSw3IEBAIGludCBtbHg1ZV9vcGVuX2xvY2tlZChzdHJ1Y3QgbmV0X2RldmljZSAqbmV0
ZGV2KTsKIGludCBtbHg1ZV9jbG9zZV9sb2NrZWQoc3RydWN0IG5ldF9kZXZpY2UgKm5ldGRl
dik7CiAKIHZvaWQgbWx4NWVfdHJpZ2dlcl9uYXBpX2ljb3NxKHN0cnVjdCBtbHg1ZV9jaGFu
bmVsICpjKTsKK3ZvaWQgbWx4NWVfdHJpZ2dlcl9uYXBpX2FzeW5jX2ljb3NxKHN0cnVjdCBt
bHg1ZV9jaGFubmVsICpjKTsKIHZvaWQgbWx4NWVfdHJpZ2dlcl9uYXBpX3NjaGVkKHN0cnVj
dCBuYXBpX3N0cnVjdCAqbmFwaSk7CiAKIGludCBtbHg1ZV9vcGVuX2NoYW5uZWxzKHN0cnVj
dCBtbHg1ZV9wcml2ICpwcml2LApkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQv
bWVsbGFub3gvbWx4NS9jb3JlL2VuL3hzay9wb29sLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9tZWxsYW5veC9tbHg1L2NvcmUvZW4veHNrL3Bvb2wuYwppbmRleCBkYjc3NmU1MTViNmEu
LjVjNTM2MGEyNWM2NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFu
b3gvbWx4NS9jb3JlL2VuL3hzay9wb29sLmMKKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
bWVsbGFub3gvbWx4NS9jb3JlL2VuL3hzay9wb29sLmMKQEAgLTEyNyw3ICsxMjcsNyBAQCBz
dGF0aWMgaW50IG1seDVlX3hza19lbmFibGVfbG9ja2VkKHN0cnVjdCBtbHg1ZV9wcml2ICpw
cml2LAogCQlnb3RvIGVycl9yZW1vdmVfcG9vbDsKIAogCW1seDVlX2FjdGl2YXRlX3hzayhj
KTsKLQltbHg1ZV90cmlnZ2VyX25hcGlfaWNvc3EoYyk7CisJbWx4NWVfdHJpZ2dlcl9uYXBp
X2FzeW5jX2ljb3NxKGMpOwogCiAJLyogRG9uJ3Qgd2FpdCBmb3IgV1FFcywgYmVjYXVzZSB0
aGUgbmV3ZXIgeGRwc29jayBzYW1wbGUgZG9lc24ndCBwcm92aWRlCiAJICogYW55IEZpbGwg
UmluZyBlbnRyaWVzIGF0IHRoZSBzZXR1cCBzdGFnZS4KQEAgLTE3OSw3ICsxNzksNyBAQCBz
dGF0aWMgaW50IG1seDVlX3hza19kaXNhYmxlX2xvY2tlZChzdHJ1Y3QgbWx4NWVfcHJpdiAq
cHJpdiwgdTE2IGl4KQogCWMgPSBwcml2LT5jaGFubmVscy5jW2l4XTsKIAogCW1seDVlX2Fj
dGl2YXRlX3JxKCZjLT5ycSk7Ci0JbWx4NWVfdHJpZ2dlcl9uYXBpX2ljb3NxKGMpOworCW1s
eDVlX3RyaWdnZXJfbmFwaV9hc3luY19pY29zcShjKTsKIAltbHg1ZV93YWl0X2Zvcl9taW5f
cnhfd3FlcygmYy0+cnEsIE1MWDVFX1JRX1dRRVNfVElNRU9VVCk7CiAKIAltbHg1ZV9yeF9y
ZXNfeHNrX3VwZGF0ZShwcml2LT5yeF9yZXMsICZwcml2LT5jaGFubmVscywgaXgsIGZhbHNl
KTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29y
ZS9lbi94c2svdHguYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29y
ZS9lbi94c2svdHguYwppbmRleCA5ZTMzMTU2ZmFjOGEuLjhhZWFiNGIyMTAzNSAxMDA2NDQK
LS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuL3hzay90
eC5jCisrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9lbi94
c2svdHguYwpAQCAtMzQsNyArMzQsNyBAQCBpbnQgbWx4NWVfeHNrX3dha2V1cChzdHJ1Y3Qg
bmV0X2RldmljZSAqZGV2LCB1MzIgcWlkLCB1MzIgZmxhZ3MpCiAJCQkJICAgICAmYy0+YXN5
bmNfaWNvc3EtPnN0YXRlKSkKIAkJCXJldHVybiAwOwogCi0JCW1seDVlX3RyaWdnZXJfbmFw
aV9pY29zcShjKTsKKwkJbWx4NWVfdHJpZ2dlcl9uYXBpX2FzeW5jX2ljb3NxKGMpOwogCX0K
IAogCXJldHVybiAwOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFu
b3gvbWx4NS9jb3JlL2VuX21haW4uYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94
L21seDUvY29yZS9lbl9tYWluLmMKaW5kZXggZTFlMDVjOWU3ZWJiLi40YTY4ODdiYTU3NDEg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9l
bl9tYWluLmMKKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3Jl
L2VuX21haW4uYwpAQCAtMjc4OSwxNiArMjc4OSwzMCBAQCBzdGF0aWMgaW50IG1seDVlX2No
YW5uZWxfc3RhdHNfYWxsb2Moc3RydWN0IG1seDVlX3ByaXYgKnByaXYsIGludCBpeCwgaW50
IGNwdSkKIAogdm9pZCBtbHg1ZV90cmlnZ2VyX25hcGlfaWNvc3Eoc3RydWN0IG1seDVlX2No
YW5uZWwgKmMpCiB7CisJc3RydWN0IG1seDVlX2ljb3NxICpzcSA9ICZjLT5pY29zcTsKIAli
b29sIGxvY2tlZDsKIAotCWlmICghdGVzdF9hbmRfc2V0X2JpdChNTFg1RV9TUV9TVEFURV9M
T0NLX05FRURFRCwgJmMtPmljb3NxLnN0YXRlKSkKLQkJc3luY2hyb25pemVfbmV0KCk7CisJ
V0FSTl9PTih0ZXN0X2JpdChNTFg1RV9TUV9TVEFURV9MT0NLX05FRURFRCwgJnNxLT5zdGF0
ZSkpOwogCi0JbG9ja2VkID0gbWx4NWVfaWNvc3Ffc3luY19sb2NrKCZjLT5pY29zcSk7Ci0J
bWx4NWVfdHJpZ2dlcl9pcnEoJmMtPmljb3NxKTsKLQltbHg1ZV9pY29zcV9zeW5jX3VubG9j
aygmYy0+aWNvc3EsIGxvY2tlZCk7CisJc2V0X2JpdChNTFg1RV9TUV9TVEFURV9MT0NLX05F
RURFRCwgJnNxLT5zdGF0ZSk7CisJc3luY2hyb25pemVfbmV0KCk7CiAKLQljbGVhcl9iaXQo
TUxYNUVfU1FfU1RBVEVfTE9DS19ORUVERUQsICZjLT5pY29zcS5zdGF0ZSk7CisJbG9ja2Vk
ID0gbWx4NWVfaWNvc3Ffc3luY19sb2NrKHNxKTsKKwltbHg1ZV90cmlnZ2VyX2lycShzcSk7
CisJbWx4NWVfaWNvc3Ffc3luY191bmxvY2soc3EsIGxvY2tlZCk7CisKKwljbGVhcl9iaXQo
TUxYNUVfU1FfU1RBVEVfTE9DS19ORUVERUQsICZzcS0+c3RhdGUpOworfQorCit2b2lkIG1s
eDVlX3RyaWdnZXJfbmFwaV9hc3luY19pY29zcShzdHJ1Y3QgbWx4NWVfY2hhbm5lbCAqYykK
K3sKKwlzdHJ1Y3QgbWx4NWVfaWNvc3EgKnNxID0gYy0+YXN5bmNfaWNvc3E7CisKKwlXQVJO
X09OKCFzcSk7CisKKwlzcGluX2xvY2tfYmgoJnNxLT5sb2NrKTsKKwltbHg1ZV90cmlnZ2Vy
X2lycShzcSk7CisJc3Bpbl91bmxvY2tfYmgoJnNxLT5sb2NrKTsKIH0KIAogdm9pZCBtbHg1
ZV90cmlnZ2VyX25hcGlfc2NoZWQoc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpKQpAQCAtMjg4
MSw3ICsyODk1LDcgQEAgc3RhdGljIGludCBtbHg1ZV9vcGVuX2NoYW5uZWwoc3RydWN0IG1s
eDVlX3ByaXYgKnByaXYsIGludCBpeCwKIAluZXRpZl9uYXBpX2FkZF9jb25maWdfbG9ja2Vk
KG5ldGRldiwgJmMtPm5hcGksIG1seDVlX25hcGlfcG9sbCwgaXgpOwogCW5ldGlmX25hcGlf
c2V0X2lycV9sb2NrZWQoJmMtPm5hcGksIGlycSk7CiAKLQlhc3luY19pY29zcV9uZWVkZWQg
PSAhIXhza19wb29sIHx8IHByaXYtPmt0bHNfcnhfd2FzX2VuYWJsZWQ7CisJYXN5bmNfaWNv
c3FfbmVlZGVkID0gISFwYXJhbXMtPnhkcF9wcm9nIHx8IHByaXYtPmt0bHNfcnhfd2FzX2Vu
YWJsZWQ7CiAJZXJyID0gbWx4NWVfb3Blbl9xdWV1ZXMoYywgcGFyYW1zLCBjcGFyYW0sIGFz
eW5jX2ljb3NxX25lZWRlZCk7CiAJaWYgKHVubGlrZWx5KGVycikpCiAJCWdvdG8gZXJyX25h
cGlfZGVsOwoKYmFzZS1jb21taXQ6IGQ4Zjg3YWE1ZmEwYTQyNzY0OTFmYThlZjQzNmNkMjI2
MDVhM2Y5YmEKLS0gCjIuNDQuMAoK

--------------GyTieBIItEzAwqNhB00HJ7GN--

