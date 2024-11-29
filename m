Return-Path: <netdev+bounces-147876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F229DEB15
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 17:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164E0282F16
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 16:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D937D1A9B30;
	Fri, 29 Nov 2024 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9WeyDcm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C094D1A76D4
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732898000; cv=none; b=pEsP7pIJfWKGZBvrDLfm7qqVkgpykjrt0IvGElXdWM94qmwcZl84h81/aiBtDM3/peV5xa5/9Aw0sw1SQM/CX7TIgW+xCYCzHIWgKQgDWbIQBd7pceZVK1x/pl4Qd9lB4HmxHYWO/E0qVdr64YyX+cyaW4GOEhXrGMk8hdZ67Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732898000; c=relaxed/simple;
	bh=ixANE1TM97/kk79pq9p1BaXxgETyrKZhPIYqkiTuoEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PGUrj/R8R3Dj9tdP4Y4fuhsYmAp2bgoM/n63SSFyrp17lEJUgOaDjbTr/6WPMtR7zplPzy83C+MFUn3evWodtkr1MYPtcwk7Hwt5t1tJhXotBf+C2nmTxv2xRXdINOkc0oSaKh73g72sRnpmgemQogi0OiK30ozdSy8uxYFDhio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X9WeyDcm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732897997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unp1zDx/rkB05CPtFabdiDNdSsNq+4B70Mcxqw/MVBA=;
	b=X9WeyDcmIvUvencb2L+7Yzqeo9rsYWDSlDa4vxUZs42s7Y8yrfg5zThaLy+nrWJAGzPjme
	SDmjHbwno+1aA47Sb7d0e6EKj8T2H9V7BVFVLG06ae2Zj84rcrmYSnAPVGk09Y0cXW6+M6
	icuap/Ab1RsYNTQ/6v9eGJ14BVlCCCQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-MNIJ_0HFMgqrxpW2Gmcvgw-1; Fri, 29 Nov 2024 11:33:16 -0500
X-MC-Unique: MNIJ_0HFMgqrxpW2Gmcvgw-1
X-Mimecast-MFC-AGG-ID: MNIJ_0HFMgqrxpW2Gmcvgw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434a72b08d9so14072355e9.2
        for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 08:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732897995; x=1733502795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=unp1zDx/rkB05CPtFabdiDNdSsNq+4B70Mcxqw/MVBA=;
        b=CIAswFcPI7dPwQToSByNWRdKzdgnHHu4+pfKzDZGlWOvFMaXdbmvCfT5c/OLJiEZeS
         ixRaaxtWJCL8jPWjEN4AcwgXq9pLIlkCklke4P70RRDI2TBeyji6Z8pVMx3h2J1GSGoD
         w6ZPJzTBGz4ufMZEtviP8b+HYlOlolVMpC845dTrJUI+oCRehBApW5c5DneOSrJlox+E
         /2pYY3iuwsUf0zKXOZ8MndLNZde3V/32Hi/XTjgPhCllNnM/zNs8+/U4vHQjHTs1PdmE
         8feAPc6cNijPtzEGLu3yKQKsOFhawsLcaSALtDyMREfdZ3pm9NFVn4IH+sz2Ba6I9Wt9
         Jx8g==
X-Forwarded-Encrypted: i=1; AJvYcCWBxWuhCD4cFc47qUs6U7gquFAaz/earAbPVvrz4OTPJAxBlyUKrf9bWcSqu3siUhWVGteNyvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCPBp8pP5m3TYfg5Y/2a7q2zCHoT19JODfhKXPNMR4ygJhkkRA
	1HtyEV50905EFGntJaMizNJ/tyJps6DmzP0nYIcZiLlMk+wGnYlv9QPLtWGCJkA/h4jcX3q5hKU
	L2pbgacDTj4A4SymuQ+kvj8GVWHEDK6EHnP4c+O3uVteJGStWGwdfVA==
X-Gm-Gg: ASbGnctR8g/eIlFK600FaMlyu7EJZFZJtywBIMOf9RFZwqwnxUKmnB6KWLSRtLDpmYk
	vRLw6I/aOIDORSuggdpBrrGBeq9QbF6zWg3M1WCTJV3Jq0ptntzeDBY4kNis+f83pVAgZiT2XRP
	d0PIb2WnE+qo0kowIIvNyZjzUkegaC/Ue5SK7TzdJh21j0aQvTR+kGt1oH+OzvPaW0C5d8wSonm
	x5OYLoTwRJsqxSm+Q3dIutrBuipP9fG0+I+uTQ9YkAll6tf+FQzc378t9BHmf6wuTwFneHXNFe/
X-Received: by 2002:a05:600c:3111:b0:430:563a:b20a with SMTP id 5b1f17b1804b1-434a9dc01b2mr106932235e9.11.1732897995175;
        Fri, 29 Nov 2024 08:33:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IES3pURBMYVzVdTXMFsHaKlxSDicnl0pEAYalfnPPgL84tyOEF+MnjfWFXfpaYWzyRjs7qEWA==
X-Received: by 2002:a05:600c:3111:b0:430:563a:b20a with SMTP id 5b1f17b1804b1-434a9dc01b2mr106931865e9.11.1732897994801;
        Fri, 29 Nov 2024 08:33:14 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e19104a0sm400133f8f.32.2024.11.29.08.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 08:33:14 -0800 (PST)
Message-ID: <ac9ae011-636d-4826-84a0-6de059e2bd69@redhat.com>
Date: Fri, 29 Nov 2024 17:33:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Networking for v6.13
To: Sasha Levin <sashal@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
 Rotem Saado <rotem.saado@intel.com>
References: <20241119161923.29062-1-pabeni@redhat.com>
 <Z0noRK6mD3tHMBov@sashalap>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z0noRK6mD3tHMBov@sashalap>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+ Kalle, Johannes, Miri and Rotem
On 11/29/24 17:13, Sasha Levin wrote:
> Hi folks,
> 
> After this PR, I started (very rarely) seeing the following warning:
> 
> [   12.020686] UBSAN: shift-out-of-bounds in drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c:1333:47
> [   12.029663] shift exponent 32 is too large for 32-bit type 'long unsigned int'
> [   12.036900] CPU: 2 UID: 0 PID: 167 Comm: modprobe Tainted: G        W          6.12.0 #1
> [   12.044988] Tainted: [W]=WARN
> [   12.047960] Hardware name: LENOVO Morphius/Morphius, BIOS Google_Morphius.13434.60.0 10/08/2020
> [   12.056653] Call Trace:
> [   12.059105]  dump_stack_lvl+0x94/0xa4
> [   12.062774]  dump_stack+0x12/0x18
> [   12.066095]  __ubsan_handle_shift_out_of_bounds+0x156/0x320
> [   12.071676]  iwl_dbg_tlv_init_cfg.cold+0x5d/0x67 [iwlwifi]
> [   12.077198]  _iwl_dbg_tlv_time_point+0x2be/0x364 [iwlwifi]
> [   12.082717]  ? __local_bh_enable_ip+0x6b/0xe8
> [   12.087078]  ? _raw_spin_unlock_bh+0x25/0x28
> [   12.091355]  iwl_run_unified_mvm_ucode+0xb0/0x380 [iwlmvm]
> [   12.096859]  ? 0xf89c9000
> [   12.099486]  ? iwl_trans_pcie_start_hw+0xbd/0x344 [iwlwifi]
> [   12.105090]  ? 0xf89c9000
> [   12.107719]  iwl_run_init_mvm_ucode+0x213/0x428 [iwlmvm]
> [   12.113059]  ? mutex_unlock+0xb/0x10
> [   12.116637]  ? iwl_trans_pcie_start_hw+0xbd/0x344 [iwlwifi]
> [   12.122244]  iwl_mvm_start_get_nvm+0x91/0x204 [iwlmvm]
> [   12.127410]  ? iwl_mvm_mei_scan_filter_init+0x65/0x7c [iwlmvm]
> [   12.133275]  iwl_op_mode_mvm_start+0x9e0/0xd08 [iwlmvm]
> [   12.138532]  ? iwl_mvm_start_get_nvm+0x204/0x204 [iwlmvm]
> [   12.143955]  _iwl_op_mode_start.isra.0+0x9a/0xd0 [iwlwifi]
> [   12.149477]  iwl_opmode_register+0x5a/0xbc [iwlwifi]
> [   12.154474]  ? 0xf87fc000
> [   12.157100]  iwl_mvm_init+0x21/0x1000 [iwlmvm]
> [   12.161562]  ? 0xf87fc000
> [   12.164188]  do_one_initcall+0x63/0x2a8
> [   12.168027]  ? __create_object+0x56/0x84
> [   12.171960]  do_init_module+0x53/0x1f4
> [   12.175716]  load_module+0x746/0x818
> [   12.179296]  ? __probestub_module_put+0x4/0x4
> [   12.183659]  init_module_from_file+0x80/0xa8
> [   12.187936]  idempotent_init_module+0xe4/0x260
> [   12.192386]  __ia32_sys_finit_module+0x4f/0xb4
> [   12.196834]  ia32_sys_call+0x2bb/0x2e44
> [   12.200672]  __do_fast_syscall_32+0x5b/0xd8
> [   12.204860]  do_fast_syscall_32+0x2b/0x60
> [   12.208873]  do_SYSENTER_32+0x15/0x18
> [   12.212538]  entry_SYSENTER_32+0xa6/0x115
> [   12.216551] EIP: 0xb7f28579
> [   12.219350] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
> [   12.238098] EAX: ffffffda EBX: 00000000 ECX: 0934ba50 EDX: 00000000
> [   12.244364] ESI: 0934ba50 EDI: 0934b8c0 EBP: 0934ba50 ESP: bfb8fd88
> [   12.250629] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
> 

I suspect the issue is due to commit
72c43f7d6562cec138536e7e6d0939692ff74482 and something like the
following should address it:
---
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 08d990ba8a79..3081508d030c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -1330,7 +1330,7 @@ void iwl_dbg_tlv_init_cfg(struct iwl_fw_runtime *fwrt)
                u32 reg_type;

                if (!*active_reg) {
-                       fwrt->trans->dbg.unsupported_region_msk |= BIT(i);
+                       fwrt->trans->dbg.unsupported_region_msk |=
BIT_ULL(i);
                        continue;
                }


