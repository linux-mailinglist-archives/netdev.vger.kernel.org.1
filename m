Return-Path: <netdev+bounces-214423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BDCB295A8
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 01:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A3D47ADB63
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 23:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B341E0083;
	Sun, 17 Aug 2025 23:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KZ7Sha/3"
X-Original-To: netdev@vger.kernel.org
Received: from sonic302-21.consmr.mail.ir2.yahoo.com (sonic302-21.consmr.mail.ir2.yahoo.com [87.248.110.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184011CAA79
	for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 23:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.248.110.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755472861; cv=none; b=tM4jzCxvdLlo5FUVVD6IScrJKZcE4tjHYAmOFBDEBmsTqrUfVortwxUfBPaup95BNN8kNUQA/tgWD4sRX063lKzOnbE+fFjbTQh7o3avWApNttb/J+/fyt66jURNeyX5RkuYszWJeqViy/tuxPZ8/FrNbh3e18Z21fwSp7RQwYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755472861; c=relaxed/simple;
	bh=9ZhVv+9ALJsMAw2kslMSpA31INMpSvGSbIKguqPL+j8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=S67TXvtrFeuWBBXaiP9eREhJ+BQI0KfzT5mGReuqw0LTEr7La5apYw1uqXDcliZ/gMq5LNHasXQlzhsZak4IjBZ+1+7ZW2JH+jsXoco3QDfh0uwAmFHpM71DJXnXXJIBkxTemUop12TfMykJoaiJOGIoiIyll4sLgHOdqgFIcrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gagniere.dev; spf=fail smtp.mailfrom=gagniere.dev; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=KZ7Sha/3; arc=none smtp.client-ip=87.248.110.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gagniere.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gagniere.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755472853; bh=is32AemcBneMo5oicrwoPfxz+v89uer9CjUyvU7oAO8=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=KZ7Sha/3B2blrcYEDkaZfKLJ401SqF0juFHCLfM6ahQ96YyPvU1wAeEheZ+uJjwI+4S9M3fX9Sy7Y9UX665GZvV0spQ+nN8ay9OELpYlSw76NR/OkSaOlyJ/EPcqxi2+wz5M6N3DNpjsRcmlWstrD2CuUoi5DAm11dBEISOhMT2XGPcUX9ycBQ8D2ke5igwgug/TKbMThvfRLOI+OwDW+LGbqGRfYjDkKCSs638GYEEQTL6gsNw2MV4hxCTem5rOqQ3R/nbcoZkUr2BybETheNxTHBkgJY1RFTaSC8DtQQg/JOGeV96YEAA28RuSEmmdrEJlUhxe6BceBuor+jQZVQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755472853; bh=EZNlthoyEiWJ5m97G9xITkpQtlKd9WBq2Jy0QeK+Qwg=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ZwyoUJuS2pX9xUlDNitgx7yO1QJxrnOS20UcgR8nnAMNa4nUtoJclmIBMXubz1ck0LiIjHMH3NRHNeN/S6MVY8F36uSDt74WLoS1oG7LEyOt5xLv6nNmVif2FWaHjCR9VZzOmyCGR3UMaYzi2PQTYb1iV7TtYPlV+leo4TWRki+xReA4mHaRNk3ryokUTcVY+qs9AXocI1g7YuoIhe5eVsl5P8WO2K40Y22mA5lNUcFJWH/kIi1u882IDIbUlsZaggGT65BIV64D8hDnLZvB0Arpr0ofMdzezk4Zy1gQZv2Fe/W9jw4ysBPScAjGFf85c39I4oSd2IdIWxiT22NNvw==
X-YMail-OSG: JnhMmkUVM1lgutZfZzFruTrvqHMG6S2k_TDNTtoJlGfBN65HmmbItUwyj1IgNGY
 GIwmfn4CTJmqLPsMnWmUPHX98DRHn_epCsud8YfiIi0x2L2K21zJc9GW3aLlKSW6W9OwSyy2K4Nt
 r8uL2iZdWbybpLrY8BqIfQrN.YRlzEEWBb1OyQ7OLrxdBVy6Rg_.lD7P9AxXqMeqtSqS3NNtF0jM
 KQW8Ayw7ICoozoWzyTmxknZy18rGOTt_AqNMFsOji73nF9bgtD4UMBNe3NngVc4Nm.h6bheEy3M9
 xokZKWTx8d8IdsNHgXtDCHm4cJ3MQw1ryTcNlopxobzJkBqrLN4FYKFNpl_mn4TstvRIXDCgR1sr
 vA4cL6.dIydTmTBj4wxM49lyXxynE00yWrEqmrEKjO2P37ALj2MXH4wLHkpqwv0jx3_eIh5EREOt
 uks0pV454Zs.Voi.8eoZMU5KbnoPipsMTH7SH6RNU2QWTedm5gpJTrEC9VdXBn5F8asGuTcjBPNZ
 g5SCwKoeEIx_ULDXsZMo2yHJpDG6xEyG6wpLxzZchLvrC8Vo0RC1tu_dA4M6r5zvZSl35LpsVQxI
 JOuZvPU44nFsGtV_xA8HefAYYF2hOn6s4iVuGFLTY8y9HjwcVSan196pWc7qRAMbT5T4D.yMV2qQ
 bfOLQ99LsEKXY3Ch8GqRlN9WgxxhTmw3WHG4v1WWJ24.dQ0tsdjmRKz_yLwLArKLOL8uSeOhkBOJ
 ywDi6NZLcX.KmGFtvkVwa.VgZTG.jB4H.bSkO8sw9I6EEZegkT2o5HuCXTykocQFwP2uynuYMnWP
 jQzs_zfg2FbLWyXylRSC37lf49tlodGphzsu650LDl9GZVk2WX3lD9mlQ7D.ZKrQHJ.cz2_vcQ2v
 QOUtStxIaUm7RwVKF4G76iu4Y64LKWpH3FhWdkKInQhlwt1iboPh2RTPryizCRzpsDDTfH1ul.1C
 u6OcLJIWz8IBxpaV_VBwRI0YkkCV17NiTxGqUgJli3gSITMJkY0g1wt1no9M1rf.iRJBsi3LUcS5
 tkCjNhF3ExoD7RSRSJFkPotv6akr9_MVcMeF_GN4sDfZfn1x9hZv3vonEMJtpLuUlh57JEFZG_5O
 3TwhaYH.cioTqT7k_Dliw9TItu7sAj_3ddWXvppW1ncNzwaX0x2EdubASR2BY1bjsr3EAafFTt9F
 1mxJnYm85LiXK3F.d_jANbOvsvh5Tl3eFUM9.bLSbB3GEup73KnbCIPjQSgVIr4cC7oZOYprZuGy
 DyzGMhsALC23iOqIn6WaTKrw.QH5y42vsX8IK1FK9B4BoTToNXOS9f8wOogzcC1s_2VeYDxbvO2F
 mwNq17Jrzl7hAFuTKnXfXJPc9jfxRILZOhjnFX._RHQ6oSTjNVjREAqPpEGX.AYrmS688KSkiggZ
 .9QLXjHkmnGd.nmh5szMQlgUbW0ZPpXwG6Ss7auJCV.Bb4tSL139_1YmXGne9gqJ7qNNktQQWsDp
 d9K_OBeRDI8EJcNRcCUNm5l3Q554n31bRfMFN_xi57EooC5sfHWVccpxqrNKoI_zmevv8QxgnIen
 4rduIWJwhreoN5p_5klr8B8iRKmEotfUhphTSC5.6a_WMiVHkAf6zMh.Rj34_gI07D6P7_vPtI51
 oy6TnoHsfmyLcEEDsF65pB9VuNl3O1wsAtsI7SAPjccZ789hCqN1rd7eQQe0m82IiI3bLE_oClYS
 ltDLMdC9P6WUGvtjYB1mylzT.ikFXR.GOM16alpkBZ7aWB6p9wxFgV1NywF1CtVx3MOtpiaKgHpx
 N6DRYtGL8y7Qp0GGCvnNpxXeYjLrF9Sm_HqR2qdR4Yd_fzR8L_K9h3k8TfJtGT05HZWOxLwp99GW
 OEavA9QdQuwxA5BdMM8tp4dBeXRxQNggF_Zjm2Is2pqfLyTRKn_ccb2morMwf3MDRj3zMJCqz2L8
 7hbuAhbvKCa5UDEUrYGV8oij5Rh.txO6zHMjfoNwqO2T4gMmVwIYRLtkiKdxKThpOcMDOkvLD2nN
 HQsedJOTMzo2f.Elp6ZE8_VPEm4aczfMfkj8IzMXuGbIY2PJqYDoBKLxSLaYsuF_QjBRoLsw0Cv0
 jBVa288NUvypWZa6BiyNwnGT1DfMPWy_3eb_uCs3RjIQJ1SWLT.DhQtmMqrkWhI.yXYHlSuj58sS
 fizKGEcO_hPY6_NCJrpwwpPajGtV9EjEXQN8iwlnOa0sMWG53DtzsCyEizgg1Gw89rSW.RVpvJKH
 HUtY4GqdvUfWDpxwHW8.NxfKFlmvgQR1sWtnPDZIIFj7oYOPLMSGn3wdnvvrzNDWeWwWu.I97
X-Sonic-MF: <antoine@gagniere.dev>
X-Sonic-ID: 784f454b-72c6-48c1-ab20-0ca07e32fe64
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Sun, 17 Aug 2025 23:20:53 +0000
Received: by hermes--production-ir2-858bd4ff7b-npgzx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9fd388458d57d074ba12a6c358d1b01d;
          Sun, 17 Aug 2025 22:30:10 +0000 (UTC)
From: Antoine Gagniere <antoine@gagniere.dev>
To: jonathan.lemon@gmail.com,
	vadim.fedorenko@linux.dev
Cc: netdev@vger.kernel.org,
	Antoine Gagniere <antoine@gagniere.dev>
Subject: [PATCH] ptp: ocp: Fix PCI delay estimation
Date: Mon, 18 Aug 2025 00:29:33 +0200
Message-ID: <20250817222933.21102-1-antoine@gagniere.dev>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250817222933.21102-1-antoine.ref@gagniere.dev>

Since linux 6.12, a sign error causes the initial value of ts_window_adjust, (used in gettimex64) to be impossibly high, causing consumers like chrony to reject readings from PTP_SYS_OFFSET_EXTENDED.

This patch fixes ts_window_adjust's inital value and the sign-ness of various format flags

Context
-------

The value stored in the read-write attribute ts_window_adjust is a number of nanoseconds subtracted to the post_ts timestamp of the reading in gettimex64, used notably in the ioctl PTP_SYS_OFFSET_EXTENDED, to compensate for PCI delay.
Its initial value is set by estimating PCI delay.

Bug
---

The PCI delay estimation starts with the value U64_MAX and makes 3 measurements, taking the minimum value.
However because the delay was stored in a s64, U64_MAX was interpreted as -1, which compared as smaller than any positive values measured.
Then, that delay is divided by ~10 and placed in ts_window_adjust, which is a u32.
So ts_window_adjust ends up with (u32)(((s64)U64_MAX >> 5) * 3) inside, which is 4294967293

Symptom
-------

The consequence was that the post_ts of gettimex64, returned by PTP_SYS_OFFSET_EXTENDED, was substracted 4.29 seconds.
As a consequence chrony rejected all readings from the PHC

Difficulty to diagnose
----------------------

Using cat to read the attribute value showed -3 because the format flags %d was used instead of %u, resulting in a re-interpret cast.

Fixes
-----

1. Using U32_MAX as initial value for PCI delays: no one is expecting an ioread to take more than 4 s
   This will correctly compare as bigger that actual PCI delay measurements.
2. Fixing the sign of various format flags

Signed-off-by: Antoine Gagniere <antoine@gagniere.dev>
---
 drivers/ptp/ptp_ocp.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index b651087f426f..153827722a63 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -1558,7 +1558,8 @@ ptp_ocp_watchdog(struct timer_list *t)
 static void
 ptp_ocp_estimate_pci_timing(struct ptp_ocp *bp)
 {
-	ktime_t start, end, delay = U64_MAX;
+	ktime_t start, end;
+	s64 delay_ns = U32_MAX; /* 4.29 seconds is high enough */
 	u32 ctrl;
 	int i;
 
@@ -1568,15 +1569,16 @@ ptp_ocp_estimate_pci_timing(struct ptp_ocp *bp)
 
 		iowrite32(ctrl, &bp->reg->ctrl);
 
-		start = ktime_get_raw_ns();
+		start = ktime_get_raw();
 
 		ctrl = ioread32(&bp->reg->ctrl);
 
-		end = ktime_get_raw_ns();
+		end = ktime_get_raw();
 
-		delay = min(delay, end - start);
+		delay_ns = min(delay_ns, ktime_to_ns(end - start));
 	}
-	bp->ts_window_adjust = (delay >> 5) * 3;
+	delay_ns = max(0, delay_ns);
+	bp->ts_window_adjust = (delay_ns >> 5) * 3;
 }
 
 static int
@@ -1894,7 +1896,7 @@ ptp_ocp_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
 	int err;
 
 	fw_image = bp->fw_loader ? "loader" : "fw";
-	sprintf(buf, "%d.%d", bp->fw_tag, bp->fw_version);
+	sprintf(buf, "%hhu.%hu", bp->fw_tag, bp->fw_version);
 	err = devlink_info_version_running_put(req, fw_image, buf);
 	if (err)
 		return err;
@@ -3196,7 +3198,7 @@ signal_show(struct device *dev, struct device_attribute *attr, char *buf)
 	i = (uintptr_t)ea->var;
 	signal = &bp->signal[i];
 
-	count = sysfs_emit(buf, "%llu %d %llu %d", signal->period,
+	count = sysfs_emit(buf, "%lli %d %lli %d", signal->period,
 			   signal->duty, signal->phase, signal->polarity);
 
 	ts = ktime_to_timespec64(signal->start);
@@ -3230,7 +3232,7 @@ period_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct ptp_ocp *bp = dev_get_drvdata(dev);
 	int i = (uintptr_t)ea->var;
 
-	return sysfs_emit(buf, "%llu\n", bp->signal[i].period);
+	return sysfs_emit(buf, "%lli\n", bp->signal[i].period);
 }
 static EXT_ATTR_RO(signal, period, 0);
 static EXT_ATTR_RO(signal, period, 1);
@@ -3244,7 +3246,7 @@ phase_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct ptp_ocp *bp = dev_get_drvdata(dev);
 	int i = (uintptr_t)ea->var;
 
-	return sysfs_emit(buf, "%llu\n", bp->signal[i].phase);
+	return sysfs_emit(buf, "%lli\n", bp->signal[i].phase);
 }
 static EXT_ATTR_RO(signal, phase, 0);
 static EXT_ATTR_RO(signal, phase, 1);
@@ -3289,7 +3291,7 @@ start_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct timespec64 ts;
 
 	ts = ktime_to_timespec64(bp->signal[i].start);
-	return sysfs_emit(buf, "%llu.%lu\n", ts.tv_sec, ts.tv_nsec);
+	return sysfs_emit(buf, "%lli.%li\n", ts.tv_sec, ts.tv_nsec);
 }
 static EXT_ATTR_RO(signal, start, 0);
 static EXT_ATTR_RO(signal, start, 1);
@@ -3444,7 +3446,7 @@ utc_tai_offset_show(struct device *dev,
 {
 	struct ptp_ocp *bp = dev_get_drvdata(dev);
 
-	return sysfs_emit(buf, "%d\n", bp->utc_tai_offset);
+	return sysfs_emit(buf, "%u\n", bp->utc_tai_offset);
 }
 
 static ssize_t
@@ -3472,7 +3474,7 @@ ts_window_adjust_show(struct device *dev,
 {
 	struct ptp_ocp *bp = dev_get_drvdata(dev);
 
-	return sysfs_emit(buf, "%d\n", bp->ts_window_adjust);
+	return sysfs_emit(buf, "%u\n", bp->ts_window_adjust);
 }
 
 static ssize_t
@@ -3964,7 +3966,7 @@ _signal_summary_show(struct seq_file *s, struct ptp_ocp *bp, int nr)
 
 	on = signal->running;
 	sprintf(label, "GEN%d", nr + 1);
-	seq_printf(s, "%7s: %s, period:%llu duty:%d%% phase:%llu pol:%d",
+	seq_printf(s, "%7s: %s, period:%lli duty:%d%% phase:%lli pol:%d",
 		   label, on ? " ON" : "OFF",
 		   signal->period, signal->duty, signal->phase,
 		   signal->polarity);
@@ -3974,7 +3976,7 @@ _signal_summary_show(struct seq_file *s, struct ptp_ocp *bp, int nr)
 	val = ioread32(&reg->status);
 	seq_printf(s, " %x]", val);
 
-	seq_printf(s, " start:%llu\n", signal->start);
+	seq_printf(s, " start:%lli\n", signal->start);
 }
 
 static void
@@ -4231,7 +4233,7 @@ ptp_ocp_summary_show(struct seq_file *s, void *data)
 
 		seq_printf(s, "%7s: %lld.%ld == %ptT TAI\n", "PHC",
 			   ts.tv_sec, ts.tv_nsec, &ts);
-		seq_printf(s, "%7s: %lld.%ld == %ptT UTC offset %d\n", "SYS",
+		seq_printf(s, "%7s: %lld.%ld == %ptT UTC offset %u\n", "SYS",
 			   sys_ts.tv_sec, sys_ts.tv_nsec, &sys_ts,
 			   bp->utc_tai_offset);
 		seq_printf(s, "%7s: PHC:SYS offset: %lld  window: %lld\n", "",
-- 
2.48.1


