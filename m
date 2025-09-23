Return-Path: <netdev+bounces-225584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42636B95A93
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B4474E2D88
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28448321F22;
	Tue, 23 Sep 2025 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MAAw+EYw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2C8321F3A
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626849; cv=none; b=MgBbIqUm0cvyh1CJOYl0PKWkbiF64QUqmS3yTnVjx/4tHKeQ/87i6+0R4wWbvWWaVdgWvsAXRsfDzECQTLF71GFN5dxvWCoTILS3KhGa5w/xVr+p3csxOAqZXKXMroaJTUs24kq+CgYQ/F/+UdNq98TdH9xiG8X/7ibXamYq8JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626849; c=relaxed/simple;
	bh=nExO9XuiNrcu0CDjAt3idck3jLqSZKCieYe2CkXKmOY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oe6ln0a0Zc3piXYxLOarIj1N6lp1/RUwaqH2K6881F/gvk8XgBYaY2P1B5WfXQOxhXJLB0qhBrHRdG5vt8D2s6esHTNMIAnBVS3sMI+ZffAq71dxawrjVCAQQBaHhr0yxFgdyU5g1wLOr3h5fwX4J1aycNhyekVUV7rXQTef6nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MAAw+EYw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e21249891so3580895e9.3
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 04:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758626845; x=1759231645; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=so1SQgkCsw7y835XopxQQ+rCSXelKEKDLiudYAtWcmQ=;
        b=MAAw+EYwqd4awuiyT9oC8mXJVST56dd1gRZttL7AznpfclJgE3TrQZ4mok+faByNDc
         I1+H6rgNHpCQecNpQE2Y5rhzwl2MGdNof/7icNyUMcn4AVDFrq7Ekt61SMoC+1bk/Y47
         keSALkOB7pYe2ccfqvn7kvOO0BPPyBwfGe0uuIF4htpzTMyoZElR1z169fxUEV208Z23
         nKJ3CtjvyyRHkA8hbZTa9Y2vKPwYr8fYl55aJHA1tSBFvJLZuc+s4LcDeMdHeji0aNa9
         xeHYlmFBXfssVDpbqeO9E6rubpEUNdTy8axip4JBAdja3odl187pbpb4zPY6eQNl3XrB
         FHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758626845; x=1759231645;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=so1SQgkCsw7y835XopxQQ+rCSXelKEKDLiudYAtWcmQ=;
        b=TGfCA0PSK0LoI37GkKN59nwG7KRA4OPIF+Lv8JktRLftNjCF+dtb1Uf9ZezKx6Pawf
         LJb3NJT6AA2V9dIQ/SOA5f/WHm56lmrjj1G+Cv3KiKbNBLzLSomW30lEutbl4hT+xxkw
         2/Ed+2PGkfTZ+Qzx1cyoPvTu4P/z6vmzXVdTIozyZ+p4xtuB1ECpzyj2GnWL1KOPZRo+
         sadUMO8kS2vN8LyPMxgGePwrw92v/y/6oa3FW2jJTX2t0dqUQ1eCYUMkkHn1Lz7Bsr33
         NxXPCgD2mwF9pRQ9QEYYhB85+Du1DDEeIWtg/J2mDUR3d3FtPH1LmXlU4dLgsBkIClVh
         wSDQ==
X-Gm-Message-State: AOJu0YwP0N2gy/PsX6vMKoeCpJG9+1Lpdxpt1FX6o66ehJoA9qho+EXC
	95Jy5j8hYVunZejCxfKzEUokAOzHASX18ZJe4Eds9ECMYTIMgZYphTj7trx1C/eqaRKAzfAqD+e
	1xf9+
X-Gm-Gg: ASbGncuo4h6dXquLOj2Y/gq7Sr/4QkSMw0gXVVCF8f56vgT0G4tXWTXHJLI/RMAc72m
	L1B+TB5OEaz1hmc+sk2ti0vdu5B87NFpKWXu6VLHUYzVLYYyPV1FK4KrnYRvdVnycFSrF9EmKqt
	LwnjH3ixzE5XLodkP84dFKQ+wegBXYIvhRHgHQ2n4adlXpWZmTcXQHtqcZDRiS2BFbuq7JFyEmp
	xIGr1yg9EQeAlVOGzQDMJktiungU5RMPMieBv54RkckhEnsw3hMquaWAtgdQi/ZlKRJZFj+y25U
	ZE6t4oRB36DWGdHLMpgZwTmB44KvzbJtqumq+vI2ZftGZMITQGhhZVTiRkc7NqBTR14RNTpWfrS
	IqOgrxcP5uKGMfj+Kls1NEPHS6wUI
X-Google-Smtp-Source: AGHT+IHxAgIxQYbAuSEqv2ENhshbn3kXGvzRRXd10eb/EZ3Ny8vjLE8V/hGk0NAfLwQYDQbulbNEKA==
X-Received: by 2002:a05:600c:46c5:b0:46d:9d28:fb5e with SMTP id 5b1f17b1804b1-46e1d97384emr24213325e9.5.1758626845068;
        Tue, 23 Sep 2025 04:27:25 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e1dc3c011sm11438255e9.6.2025.09.23.04.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:27:24 -0700 (PDT)
Date: Tue, 23 Sep 2025 14:27:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ij@kernel.org>
Cc: netdev@vger.kernel.org
Subject: [bug report] tcp: accecn: AccECN option
Message-ID: <aNKEGWyWV9LWW3i5@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello Ilpo Järvinen,

Commit b5e74132dfbe ("tcp: accecn: AccECN option") from Sep 16, 2025
(linux-next), leads to the following Smatch static checker warning:

	net/ipv4/tcp_output.c:747 tcp_options_write()
	error: we previously assumed 'tp' could be null (see line 711)

net/ipv4/tcp_output.c
    630 static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
    631                               const struct tcp_request_sock *tcprsk,
    632                               struct tcp_out_options *opts,
    633                               struct tcp_key *key)
    634 {
    635         u8 leftover_highbyte = TCPOPT_NOP; /* replace 1st NOP if avail */
    636         u8 leftover_lowbyte = TCPOPT_NOP;  /* replace 2nd NOP in succession */
    637         __be32 *ptr = (__be32 *)(th + 1);
    638         u16 options = opts->options;        /* mungable copy */
    639 
    640         if (tcp_key_is_md5(key)) {
    641                 *ptr++ = htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
    642                                (TCPOPT_MD5SIG << 8) | TCPOLEN_MD5SIG);
    643                 /* overload cookie hash location */
    644                 opts->hash_location = (__u8 *)ptr;
    645                 ptr += 4;
    646         } else if (tcp_key_is_ao(key)) {
    647                 ptr = process_tcp_ao_options(tp, tcprsk, opts, key, ptr);
                                                     ^^
Sometimes dereferenced here.

    648         }
    649         if (unlikely(opts->mss)) {
    650                 *ptr++ = htonl((TCPOPT_MSS << 24) |
    651                                (TCPOLEN_MSS << 16) |
    652                                opts->mss);
    653         }
    654 
    655         if (likely(OPTION_TS & options)) {
    656                 if (unlikely(OPTION_SACK_ADVERTISE & options)) {
    657                         *ptr++ = htonl((TCPOPT_SACK_PERM << 24) |
    658                                        (TCPOLEN_SACK_PERM << 16) |
    659                                        (TCPOPT_TIMESTAMP << 8) |
    660                                        TCPOLEN_TIMESTAMP);
    661                         options &= ~OPTION_SACK_ADVERTISE;
    662                 } else {
    663                         *ptr++ = htonl((TCPOPT_NOP << 24) |
    664                                        (TCPOPT_NOP << 16) |
    665                                        (TCPOPT_TIMESTAMP << 8) |
    666                                        TCPOLEN_TIMESTAMP);
    667                 }
    668                 *ptr++ = htonl(opts->tsval);
    669                 *ptr++ = htonl(opts->tsecr);
    670         }
    671 
    672         if (OPTION_ACCECN & options) {
    673                 const u32 *ecn_bytes = opts->use_synack_ecn_bytes ?
    674                                        synack_ecn_bytes :
    675                                        tp->received_ecn_bytes;
                                               ^^^^
Dereference

    676                 const u8 ect0_idx = INET_ECN_ECT_0 - 1;
    677                 const u8 ect1_idx = INET_ECN_ECT_1 - 1;
    678                 const u8 ce_idx = INET_ECN_CE - 1;
    679                 u32 e0b;
    680                 u32 e1b;
    681                 u32 ceb;
    682                 u8 len;
    683 
    684                 e0b = ecn_bytes[ect0_idx] + TCP_ACCECN_E0B_INIT_OFFSET;
    685                 e1b = ecn_bytes[ect1_idx] + TCP_ACCECN_E1B_INIT_OFFSET;
    686                 ceb = ecn_bytes[ce_idx] + TCP_ACCECN_CEB_INIT_OFFSET;
    687                 len = TCPOLEN_ACCECN_BASE +
    688                       opts->num_accecn_fields * TCPOLEN_ACCECN_PERFIELD;
    689 
    690                 if (opts->num_accecn_fields == 2) {
    691                         *ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
    692                                        ((e1b >> 8) & 0xffff));
    693                         *ptr++ = htonl(((e1b & 0xff) << 24) |
    694                                        (ceb & 0xffffff));
    695                 } else if (opts->num_accecn_fields == 1) {
    696                         *ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
    697                                        ((e1b >> 8) & 0xffff));
    698                         leftover_highbyte = e1b & 0xff;
    699                         leftover_lowbyte = TCPOPT_NOP;
    700                 } else if (opts->num_accecn_fields == 0) {
    701                         leftover_highbyte = TCPOPT_ACCECN1;
    702                         leftover_lowbyte = len;
    703                 } else if (opts->num_accecn_fields == 3) {
    704                         *ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
    705                                        ((e1b >> 8) & 0xffff));
    706                         *ptr++ = htonl(((e1b & 0xff) << 24) |
    707                                        (ceb & 0xffffff));
    708                         *ptr++ = htonl(((e0b & 0xffffff) << 8) |
    709                                        TCPOPT_NOP);
    710                 }
    711                 if (tp) {
                            ^^
Here we assume tp can be NULL

    712                         tp->accecn_minlen = 0;
    713                         tp->accecn_opt_tstamp = tp->tcp_mstamp;
    714                         if (tp->accecn_opt_demand)
    715                                 tp->accecn_opt_demand--;
    716                 }
    717         }
    718 
    719         if (unlikely(OPTION_SACK_ADVERTISE & options)) {
    720                 *ptr++ = htonl((leftover_highbyte << 24) |
    721                                (leftover_lowbyte << 16) |
    722                                (TCPOPT_SACK_PERM << 8) |
    723                                TCPOLEN_SACK_PERM);
    724                 leftover_highbyte = TCPOPT_NOP;
    725                 leftover_lowbyte = TCPOPT_NOP;
    726         }
    727 
    728         if (unlikely(OPTION_WSCALE & options)) {
    729                 u8 highbyte = TCPOPT_NOP;
    730 
    731                 /* Do not split the leftover 2-byte to fit into a single
    732                  * NOP, i.e., replace this NOP only when 1 byte is leftover
    733                  * within leftover_highbyte.
    734                  */
    735                 if (unlikely(leftover_highbyte != TCPOPT_NOP &&
    736                              leftover_lowbyte == TCPOPT_NOP)) {
    737                         highbyte = leftover_highbyte;
    738                         leftover_highbyte = TCPOPT_NOP;
    739                 }
    740                 *ptr++ = htonl((highbyte << 24) |
    741                                (TCPOPT_WINDOW << 16) |
    742                                (TCPOLEN_WINDOW << 8) |
    743                                opts->ws);
    744         }
    745 
    746         if (unlikely(opts->num_sack_blocks)) {
--> 747                 struct tcp_sack_block *sp = tp->rx_opt.dsack ?
                                                    ^^^^^^^^^^^^^^^^
Unchecked dereference here.

    748                         tp->duplicate_sack : tp->selective_acks;
    749                 int this_sack;
    750 
    751                 *ptr++ = htonl((leftover_highbyte << 24) |
    752                                (leftover_lowbyte << 16) |
    753                                (TCPOPT_SACK <<  8) |
    754                                (TCPOLEN_SACK_BASE + (opts->num_sack_blocks *
    755                                                      TCPOLEN_SACK_PERBLOCK)));
    756                 leftover_highbyte = TCPOPT_NOP;
    757                 leftover_lowbyte = TCPOPT_NOP;
    758 
    759                 for (this_sack = 0; this_sack < opts->num_sack_blocks;
    760                      ++this_sack) {
    761                         *ptr++ = htonl(sp[this_sack].start_seq);
    762                         *ptr++ = htonl(sp[this_sack].end_seq);
    763                 }
    764 
    765                 tp->rx_opt.dsack = 0;
    766         } else if (unlikely(leftover_highbyte != TCPOPT_NOP ||
    767                             leftover_lowbyte != TCPOPT_NOP)) {
    768                 *ptr++ = htonl((leftover_highbyte << 24) |
    769                                (leftover_lowbyte << 16) |
    770                                (TCPOPT_NOP << 8) |
    771                                TCPOPT_NOP);
    772                 leftover_highbyte = TCPOPT_NOP;
    773                 leftover_lowbyte = TCPOPT_NOP;
    774         }
    775 
    776         if (unlikely(OPTION_FAST_OPEN_COOKIE & options)) {
    777                 struct tcp_fastopen_cookie *foc = opts->fastopen_cookie;
    778                 u8 *p = (u8 *)ptr;
    779                 u32 len; /* Fast Open option length */
    780 
    781                 if (foc->exp) {
    782                         len = TCPOLEN_EXP_FASTOPEN_BASE + foc->len;
    783                         *ptr = htonl((TCPOPT_EXP << 24) | (len << 16) |
    784                                      TCPOPT_FASTOPEN_MAGIC);
    785                         p += TCPOLEN_EXP_FASTOPEN_BASE;
    786                 } else {
    787                         len = TCPOLEN_FASTOPEN_BASE + foc->len;
    788                         *p++ = TCPOPT_FASTOPEN;
    789                         *p++ = len;
    790                 }
    791 
    792                 memcpy(p, foc->val, foc->len);
    793                 if ((len & 3) == 2) {
    794                         p[foc->len] = TCPOPT_NOP;
    795                         p[foc->len + 1] = TCPOPT_NOP;
    796                 }
    797                 ptr += (len + 3) >> 2;
    798         }
    799 
    800         smc_options_write(ptr, &options);
    801 
    802         mptcp_options_write(th, ptr, tp, opts);
                                             ^^
The last dereference is checked for NULL but the others aren't.


    803 }

regards,
dan carpenter

