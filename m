Return-Path: <netdev+bounces-137892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ACC9AB096
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B111C22518
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 14:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFB819E965;
	Tue, 22 Oct 2024 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DW+eIAi0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A920136338
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606509; cv=none; b=YMOsjMcxVWOl6gXkaizLQEDCrpWxxWw94S3y7vpySizczVxmECH7L/HaI93J/NZI30wRXTluRYWkAi+ndkDQFIBzW64b9l1IAm6CytRXo+soCwCMSs1Fo3dkKyi33ojCwvTgg0S+8UKA8z8LL3mOtKE62ojTRQdqKhCekblCmww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606509; c=relaxed/simple;
	bh=UvW/EIUqOGCNTRVCwMkVKOz5Lk7XXXMET8bipDLaGb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEQJbdUpFrBDbdnENiAUWr+S+TavjwdBk06sZlqGiBYPd4OWEWf6FmSrn/UBao7cQMSsa3EVMFEXIhBAMtEeGLWC9IUt3FgMFZTxSif2im27yJbJrWX+KCqPJexfSAzG+Ae8zpnLnrv9glSZJsYEnKUUXZs90Ebjt3IoICC2a7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DW+eIAi0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729606506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/rUUXr6la27UtVoKr8Jzs1BKo8PBqHiu5Iz8aLcJu/o=;
	b=DW+eIAi0tmAyPPu3xKt7MxDSANVLNMU4CBYVH6fEKygEJjqHh91/NcxbiOXm6kECmZG59Z
	dKYtz8cxhYS5QkrcdMU1Bp+npHRlrsQz1MbfYi1MYffDLVihVHprbf4LlHGDQjk1ZK5xV+
	th2TA7Z5qwjEEfKl6JYGS5QYkZPz1BE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-C73ertCoNMq-0PDvuec1SA-1; Tue, 22 Oct 2024 10:15:05 -0400
X-MC-Unique: C73ertCoNMq-0PDvuec1SA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315af466d9so39565185e9.3
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 07:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729606504; x=1730211304;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rUUXr6la27UtVoKr8Jzs1BKo8PBqHiu5Iz8aLcJu/o=;
        b=jt4YDaphe+dcpIWJqhVdEEOtdL7E4CsBb3HH4zx/oHt02a5F7XFVnDAGl26l9ETaMS
         puq9Ua9NXBZeoo97HsCDbtDoKQ342sP3PybkoullcbLDu6v816BysYB4eN43xhb/8APj
         hG+eDfHTWmNoHg2qQATgwo0YSosa1l6Fjh1AlAcDnp5BeO8/WK224PRya9YDumv9HyNc
         nm+9yzBZ8eP25cTVXwfKPhEk/mRCW6GV6W8824ZF2vcsVaxbIQpFO88e39HDOGNxjQBP
         ZErfgRTwPfz78jvLKG7ZSNkoREg0Zpqf2rThRpxWxDAZWP+3Tpx4Rjvf68fPtz8LY+pM
         h26Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfZy0SoeNtO8sPKNxPxIp422jiPVoxDJNtkFEutWzEH9CT9+MN1WpFgrIeL+jhXCZhCGbzW+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMS8u1Fu0VswtfVrJHY/oOGDblkpMT1GJFOx8KFWZ6PC5SfHGH
	5JqT5pwwGNcS6/ynGe2J95ykH1Kv1RkuB6eNfVE7hJLAqBoIkn44C32nMXuJoWjhQtTSs42mJRl
	VKd2MAIgnx9ZFwR6CjYNKhCd9CMCYLVQ2FtYVkwSGupo6R5Y3t3rI
X-Received: by 2002:a05:600c:3592:b0:431:586e:7e7 with SMTP id 5b1f17b1804b1-43161634f28mr126111045e9.1.1729606503923;
        Tue, 22 Oct 2024 07:15:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhExv0Aqskml1SfJxb1qUqYC5dGCntpwGGVJCs0D0hjswplvviaggVBRCP6Q+cv809Q/VhiA==
X-Received: by 2002:a05:600c:3592:b0:431:586e:7e7 with SMTP id 5b1f17b1804b1-43161634f28mr126110785e9.1.1729606503576;
        Tue, 22 Oct 2024 07:15:03 -0700 (PDT)
Received: from [10.43.17.17] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37d4esm6783856f8f.3.2024.10.22.07.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 07:15:02 -0700 (PDT)
Message-ID: <5f930d8b-42fa-4bde-813e-cf90d3b866be@redhat.com>
Date: Tue, 22 Oct 2024 16:15:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the bpf-next tree with Linus' tree
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Simon Sundberg <simon.sundberg@kau.se>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
References: <20241022120211.2a5d41ed@canb.auug.org.au>
 <CAEf4BzamHrmdwRFKAr9MGSmaVtrJT3-ru=KPXEcO981XZsM+Ew@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAEf4BzamHrmdwRFKAr9MGSmaVtrJT3-ru=KPXEcO981XZsM+Ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/22/24 05:07, Andrii Nakryiko wrote:
> On Mon, Oct 21, 2024 at 6:02 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi all,
>>
>> Today's linux-next merge of the bpf-next tree got a conflict in:
>>
>>   tools/testing/selftests/bpf/Makefile
>>
>> between commit:
>>
>>   f91b256644ea ("selftests/bpf: Add test for kfunc module order")
>>
>> from Linus' tree and commit:
>>
>>   c3566ee6c66c ("selftests/bpf: remove test_tcp_check_syncookie")
>>
>> from the bpf-next tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>>
>> --
>> Cheers,
>> Stephen Rothwell
>>
>> diff --cc tools/testing/selftests/bpf/Makefile
>> index 75016962f795,6d15355f1e62..000000000000
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@@ -154,11 -153,9 +153,10 @@@ TEST_PROGS_EXTENDED := with_addr.sh
>>
>>   # Compile but not part of 'make run_tests'
>>   TEST_GEN_PROGS_EXTENDED = \
>> -       flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
>> -       test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
>> -       xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
>> -       xdp_features bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
>> -       bpf_test_modorder_y.ko
>> +       flow_dissector_load test_flow_dissector test_lirc_mode2_user xdping \
>> +       test_cpp runqslower bench bpf_testmod.ko xskxceiver xdp_redirect_multi \
>>  -      xdp_synproxy veristat xdp_hw_metadata xdp_features bpf_test_no_cfi.ko
>> ++      xdp_synproxy veristat xdp_hw_metadata xdp_features bpf_test_no_cfi.ko \
>> ++      bpf_test_modorder_x.ko bpf_test_modorder_y.ko
>>
>>   TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
>>
>> @@@ -301,22 -302,11 +303,24 @@@ $(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF
>>   $(OUTPUT)/bpf_test_no_cfi.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_test_no_cfi/Makefile bpf_test_no_cfi/*.[ch])
>>         $(call msg,MOD,,$@)
>>         $(Q)$(RM) bpf_test_no_cfi/bpf_test_no_cfi.ko # force re-compilation
>> -       $(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=$(RESOLVE_BTFIDS) -C bpf_test_no_cfi
>> +       $(Q)$(MAKE) $(submake_extras) -C bpf_test_no_cfi \
>> +               RESOLVE_BTFIDS=$(RESOLVE_BTFIDS)         \
>> +               EXTRA_CFLAGS='' EXTRA_LDFLAGS=''
>>         $(Q)cp bpf_test_no_cfi/bpf_test_no_cfi.ko $@
>>
>>  +$(OUTPUT)/bpf_test_modorder_x.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_test_modorder_x/Makefile bpf_test_modorder_x/*.[ch])
>>  +      $(call msg,MOD,,$@)
>>  +      $(Q)$(RM) bpf_test_modorder_x/bpf_test_modorder_x.ko # force re-compilation
>>  +      $(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=$(RESOLVE_BTFIDS) -C bpf_test_modorder_x
>>  +      $(Q)cp bpf_test_modorder_x/bpf_test_modorder_x.ko $@
>>  +
>>  +$(OUTPUT)/bpf_test_modorder_y.ko: $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard bpf_test_modorder_y/Makefile bpf_test_modorder_y/*.[ch])
>>  +      $(call msg,MOD,,$@)
>>  +      $(Q)$(RM) bpf_test_modorder_y/bpf_test_modorder_y.ko # force re-compilation
>>  +      $(Q)$(MAKE) $(submake_extras) RESOLVE_BTFIDS=$(RESOLVE_BTFIDS) -C bpf_test_modorder_y
> 
> This and above will need the EXTRA_CFLAGS and EXTRA_LDFLAGS additions
> that we have for bpf_test_no_cfi.ko. For now, I'll unland the patch
> set to avoid this conflict and breakage. We'll reapply once bpf is
> merged into bpf-next. Viktor, please rebase to take into account these
> new modorder.ko additions.

Thanks Andrii.

I rebased my patches on top of the bpf tree, please let me know when I
can resend them for bpf-next.

Viktor

> 
> 
>>  +      $(Q)cp bpf_test_modorder_y/bpf_test_modorder_y.ko $@
>>  +
>>  +
>>   DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
>>   ifneq ($(CROSS_COMPILE),)
>>   CROSS_BPFTOOL := $(SCRATCH_DIR)/sbin/bpftool
> 


