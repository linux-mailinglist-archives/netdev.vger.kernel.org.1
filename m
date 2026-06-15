Return-Path: <netdev+bounces-299650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hsyeDIWFMGpbUAUAu9opvQ
	(envelope-from <netdev+bounces-299650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:06:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DF668A87B
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:06:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.s=20251104 header.b=mda5SHVl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299650-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299650-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=networkplumber.org (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BBC4301D32E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719D53BBFA8;
	Mon, 15 Jun 2026 23:06:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D713AEB2C
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 23:06:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781564802; cv=none; b=prFcNpJKo3IE6jg+b+90E8i5hbBJzbGETMixPMCXGaY7QK/QKrGIrCbzDjUU6ljm3Ujumvf9YsmSk4aYaNR52/dh3daLVyEt6n7ZNXspxkyiLihMkC6jPini6BFgcBF+aMh7fa3BnVXY/wU4DBodUxO6+iZADGrrdEqs7bcqrPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781564802; c=relaxed/simple;
	bh=IcstL6x8+tOsaHFNpd470Yp9K2WSrQVkfu9lGsT3Tbo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=JJxLrKy3v3GoflIru9o3xydSYsNk0fsEzZPucWVIKUcSCI0Q1UdnA6lUxYl+AHPiYRvKTa5pG44WjzGbYGpmkr374UJf9QHp/xlQf2T8RPh1xK9xsm58DueTKDptjtK6+cWGsPfA/3Jm9JQsZOmwaI0vgr2fyFfyDlPNPLUkf5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=mda5SHVl; arc=none smtp.client-ip=74.125.82.170
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-304cf518c9dso6269409eec.1
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 16:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781564800; x=1782169600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r2TlrQllXy7Veio/slo2VFQ94w4OxnfYK/WQGKcvMVw=;
        b=mda5SHVlliWo0YmiPk4//1fIQ8BwqZspPN29OfhK/9OiZnrB9BhvOIqc7hRBlqPPJn
         PMcGvjyeS3UQV77vhq8qoyxrhy9zOBGtUQ/UZx/GuqLpddSZ4jr8jvCSU5et4b03t4N5
         nT6W1E9Zn09DVegZ+ptGYqbk/V0V+StbUHT6arYJ4ohpukL/yVq9cQir46x0O24AvWuw
         lLL6RNvdz/kf4DQcc+bQtMhValRNpvwUr1U7JAPmDqCBstXMaTqX6LNwivM7ZWW7TBLc
         v0YAegv/c0dR50JJ+DaWSuWxLCJBtgMmjAQ05sB2qPFbgc/YVUJwF2dzwVCrMCLsBeiU
         RQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781564800; x=1782169600;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r2TlrQllXy7Veio/slo2VFQ94w4OxnfYK/WQGKcvMVw=;
        b=sQ9A/q5lkB8SQitF3VKEHtPV5YKJIyLZLm8aAUBJqCesRSnReOnmkooWXHbbbPewmo
         +9IEclc6JFSIfcoAd/18PFs60d2arz3AXoTHi9ZF9CbDao+SHrBCfxC6mC9HvONddqUq
         sP2pvzj4//sSCAw4kA8OAPKmX6yoLfSotF+T1KfL7P9iibPkMcOQK5qxCFfjYwDdsy4C
         U9xtzOPpBfnLfmynu10C9kwfjZo+CWpN9eSuxKxXtMqKM1ZiPXGquwxm3yL/+QHVLcSi
         8pZatk7yMqOxTU0ISMjXv8ZLvqV4m2hgdQbXBVtG5doa4U4DjvXhbEPh0wXwAv31KbdR
         0gsA==
X-Gm-Message-State: AOJu0Yz2tDojPUvx4AkwDLOldPpmMH6wWy47ZXVRcEMLDkFV/adOmzuc
	w3MJdjlhv6XghaG7XV4ZiamCDw3/jYMQ+sD3xsTstBtTjp3Qur+2gKWO6ndXWGoyEfFE31iu5yr
	RNKxD
X-Gm-Gg: Acq92OG7Nqkjj9FKnWZx0cELPvWY4+q0ymNZcrFlUo3/qYH5OHJry4p6jNbVPUsNmaH
	SynkISbQZ8QnHlmMBHKC7HKF6EQDL4XndXSEh++4dyrR8yrqx/y/ckkgruXystulBATp87MBC1k
	7ULole3AOpqigtpBOLBHHXt0tjcfawT8/eunqMx3BlnEuf8/M24Ej+2UQPrvjHudg7QA6OmQfbd
	cJ4HZStdN0nmxtKcZJBwrhjlfBNOg1SwtNF4C/k1r4Qzc/60+2KfKe/DEPxQf3pyL2W3rhf5zlK
	P8+1bc0DZ+GGQO50tg3YdxH5b6/xpDRVRg3LOMrv/elu+/Yd6B7S3HuDHaZGphhoQtl/fPJz1yt
	GMU58Owvwbb+MXgVRQySm0Xtsu7YsiNYI/UA/QieRqzGtMC9aCvNl56L28F2bs1K4DB2k1xpcCV
	9dEV3jbHuvdQHqWNAe6BBrUAqz2kXvwwaf2W6ZY0PJD1Kisc0C2I3pJ228B95JPkcs
X-Received: by 2002:a05:7300:4350:b0:2be:7fc2:fc38 with SMTP id 5a478bee46e88-3093551a511mr6941345eec.5.1781564799802;
        Mon, 15 Jun 2026 16:06:39 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91fb97sm17328256eec.14.2026.06.15.16.06.39
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 16:06:39 -0700 (PDT)
Date: Mon, 15 Jun 2026 16:06:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: [ANNOUNCE] iproute2 7.1 release
Message-ID: <20260615160636.412a064e@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-299650-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[phoenix.local:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,networkplumber-org.20251104.gappssmtp.com:dkim,networkplumber.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68DF668A87B

This is the regular release of iproute2 corresponding to the 7.1 kernel.

The main theme this cycle is wider JSON output coverage. Victor
Nogueira added JSON support to the HFSC, QFQ, and multiq
qdiscs. Matthieu Baerts added JSON to the timestamp helper and MPTCP
monitor, and Vitaly Grinberg changed dpll monitor mode to send one
object per event in JSON.

The dpll command saw the most feature work. Petr Oros added
client-side filtering for device and pin show, including filtering
pins by parent-device, parent-pin, direction, and state, and aligned
the help and man page notation with the actual option parsing. Ivan
Vecera fixed several man page correctness issues.

Michael Guralnik added FRMR pools support to rdma, with a show command
and set commands for aging and pinned, aligned to the merged kernel
UAPI. Ioana Lazea enabled 64-bit burst values for tc-tbf and
tc-htb. Eric Dumazet added support for TCP delack timers to ss and
forced a flush in monitor mode.

Smaller changes: Justin Iurman added seg6 tunsrc support in lwtunnel
with updated encap documentation; Matthieu Baerts made MPTCP stream
closure uniform; Hangbin Liu added actor and partner churn state to
bond slave output; Jiri Pirko showed the devlink instance index in dev
output and added an mnl_attr_get_uint() fallback; and the obsolete
hamradio protocols were removed. Kernel headers were refreshed by
David Ahern.

One behavior change worth noting for packagers and scripters: 
libnetlink now flushes stdout only in monitor mode, pairing with the ss monitor flush change.

Download:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-7.1.0.tar.gz

Repository for current release:
    https://github.com/shemminger/iproute2.git
    git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

And future release (net-next):
    git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

David Ahern (3):
      Update kernel headers
      Update kernel headers
      Update kernel headers

Eric Dumazet (2):
      ss: add support for TCP delack timers
      ss: force a flush in monitor mode

Hangbin Liu (1):
      iplink: bond_slave: print actor and partner churn state

Ioana Lazea (2):
      tc/tbf: enable use of 64 bit burst
      tc/htb: enable use of 64 bit burst

Ivan Vecera (1):
      dpll: fix man page correctness issues

Jiri Pirko (2):
      mnl: add fallback implementation for mnl_attr_get_uint()
      devlink: show devlink instance index in dev output

Justin Iurman (2):
      seg6: add tunsrc support in iproute_lwtunnel
      man8: update seg6 encap documentation

Matthieu Baerts (NGI0) (3):
      mptcp: uniform stream closure
      utils: timestamp: add JSON support
      mptcp: monitor: add JSON support

Michael Guralnik (5):
      rdma: Update headers
      rdma: Add resource FRMR pools show command
      rdma: Add FRMR pools set aging command
      rdma: Add FRMR pools set pinned command
      rdma: Align FRMR pool UAPI names with merged kernel UAPI

Petr Oros (5):
      dpll: add client-side filtering for device show
      dpll: add client-side filtering for pin show
      dpll: add pin filtering by parent-device and parent-pin
      dpll: add direction and state filtering for pin show
      dpll: align help and man notation with actual option parsing

Stephen Hemminger (4):
      uapi: update to 7.1-rc1
      remove hamradio protocols
      libnetlink: flush stdout only in monitor mode
      v7.1.0

Victor Nogueira (3):
      tc: Add JSON output support to HFSC
      tc: Add JSON output support to QFQ
      tc: Add JSON output support to multiq

Vitaly Grinberg (1):
      dpll: Send object per event in JSON monitor mode


