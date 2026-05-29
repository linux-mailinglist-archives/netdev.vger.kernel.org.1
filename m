Return-Path: <netdev+bounces-293243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPZiOZLyGWp10AgAu9opvQ
	(envelope-from <netdev+bounces-293243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:09:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 781EA608458
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5391B3144EBC
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D2E44B675;
	Fri, 29 May 2026 20:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1FsqaaX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9723409629;
	Fri, 29 May 2026 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084868; cv=none; b=GQoaUL6PoP8ntuY/vrC1lOsALibQ8f89W7Oleb6+BVhZbnucse59PUtw0FBgbWPiyUVWrwNT4YMza9UTYI560oG5tIAoJB6M9OaHdKYIfsO9zM8S0L9yk2ugSIkjJ97KdWyeikZ1v9bDA2KH8hJSDdDFNu4ytlEFH9+qbz47zoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084868; c=relaxed/simple;
	bh=+R7XSpN6ilecmjqcuCuZezg0eoN+spQg6JBV5nfvJuU=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=XQoXxZO5kOVpCx/GxwpLZoH41gyOhDUMJAemmYM6U9HnUX/tPy5HPvBaSIJzbIGzgttOKCpS8q+BAwDCuX6p/fsq49c76QypJaquo+A6qUWGqW7FzO7iajhLwNrd1GiHyo0hRG9wrruxkV3p3+mc/MqhXNauAn0BmN9TF88fDB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1FsqaaX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58E31F00893;
	Fri, 29 May 2026 20:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780084867;
	bh=s9+Lz026QcH5bg8yJpyql8pfzxPiIysiXMh+fVqDlzk=;
	h=Date:From:To:Cc:Subject:References;
	b=l1FsqaaXGqD7R54MAvOyntq0dp+NJaYnuv3I/6d2D7kjvx5xm1BKcAXYtVL7nhypg
	 MkDbqqDK3amPIPsRUDej+mq+iUW8REPRKPMEAtdR+OSwxyE0F7ZqKHdC8zVGfGYTjf
	 NLGm9Cmtvtmv5Ier2DGSA8TJqyDb+pIPZU67jJFlvLJJ2Hnv5cHP38rJOuCq/0Y8Ar
	 t/69ilYKyGqlUj1R0lqu4F6JYxomLpuM4Dh+xOVN2HCUx4iV1ROInItGX/ynNqGCR2
	 IBpIxfNRKz9W+RXUS5JyeeRMMYORtlgkKzbZ3WdWxm3KJrKzCTFlnX2Q5/EOgeXcTS
	 cAOR+pwTYrJDw==
Date: Fri, 29 May 2026 22:01:05 +0200
Message-ID: <20260529195557.897808371@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
 Miroslav Lichvar <mlichvar@redhat.com>,
 John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 thomas.weissschuh@linutronix.de,
 Arthur Kiyanovski <akiyano@amazon.com>,
 Rodolfo Giometti <giometti@enneenne.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>,
 kvmarm@lists.linux.dev,
 Oliver Upton <oupton@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Peter Hilber <peter.hilber@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux.dev,
 linux-wireless@vger.kernel.org,
 linux-sound@vger.kernel.org,
 David Woodhouse <dwmw@amazon.co.uk>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [patch V2 19/25] ptp: Use system_device_crosststamp::sys_systime
References: <20260529193435.921555544@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293243-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,vger.kernel.org,suse.com,intel.com,nvidia.com,oss.qualcomm.com,amazon.co.uk];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,amazon.co.uk:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 781EA608458
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thomas Gleixner <tglx@kernel.org>

.. to prepare for cross timestamps with variable clock IDs.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: David Woodhouse <dwmw@amazon.co.uk>
Tested-by: Arthur Kiyanovski <akiyano@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/ptp/ptp_chardev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -333,7 +333,7 @@ static long ptp_sys_offset_precise(struc
 	ts = ktime_to_timespec64(xtstamp.device);
 	precise_offset.device.sec = ts.tv_sec;
 	precise_offset.device.nsec = ts.tv_nsec;
-	ts = ktime_to_timespec64(xtstamp.sys_realtime);
+	ts = ktime_to_timespec64(xtstamp.sys_systime);
 	precise_offset.sys_realtime.sec = ts.tv_sec;
 	precise_offset.sys_realtime.nsec = ts.tv_nsec;
 	ts = ktime_to_timespec64(xtstamp.sys_monoraw);




