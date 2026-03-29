Return-Path: <netdev+bounces-272848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cULcH9CbyGnAnwUAu9opvQ
	(envelope-from <netdev+bounces-272848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 05:26:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD73350927
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 05:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 089A13002D1B
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 03:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3331E9B1A;
	Sun, 29 Mar 2026 03:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vanvalzah-com.20230601.gappssmtp.com header.i=@vanvalzah-com.20230601.gappssmtp.com header.b="RMQVY/Fp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565091F1537
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 03:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774754761; cv=none; b=bNvgE7/LV4iZGi1P6XbbRV5I5QEsOhyrpW7cYbNFX46FWHu+iRWevrQcD8JyBOklLOPJ4fwLpsPJgTgS4/vDSFbebFPqTjsIouffgbsw5O4R2yZGmprsK1jiYPG4CbJw7kkWNjmsGUSpImFMUbJlnlYg4Pr9EngtD5Xa/Mhit7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774754761; c=relaxed/simple;
	bh=Tmj7sT6JMcM9Fj3FQ4uXM6kwuO78E+sGsqm3ZsWhdVg=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=cYqSWsZOLERA6WMPNkovd6cIGbLxa8pvOTy4L5/lzad4TpDsSeiv4vrI9lHoIilV/Y1uhNZ73NyRHw0j8joFswGEswV17ErL0l4Y0H92qd3D5rVzWU07usA97vftLPdAYtMwbj3Sqs+zLb5RFV5JCmZq4z2jlNePTxglKsQeHFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vanvalzah.com; spf=none smtp.mailfrom=vanvalzah.com; dkim=pass (2048-bit key) header.d=vanvalzah-com.20230601.gappssmtp.com header.i=@vanvalzah-com.20230601.gappssmtp.com header.b=RMQVY/Fp; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vanvalzah.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=vanvalzah.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-467d9ca391cso1338316b6e.3
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 20:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanvalzah-com.20230601.gappssmtp.com; s=20230601; t=1774754755; x=1775359555; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q3zHZR2nqCQ4BfQwwL3YtsGWqRQDle8jBml0c4WJz+U=;
        b=RMQVY/FpftYKIB9OKNjhAwsE5qpHgyHMiOOkmY1Hd/+i0nPNpcdzf4dzRQ0juuki8h
         lhr89/yr9QhZ0m2zbVkIsoBgcFda2hno5xJ5KvFodtskh8Ge8ROSFgkV6l5ee6nmzW+x
         cZ15Aelghbyh66I49u23YJfM/TYJlfRkRXmi+0tdwfTXzmPbsaRR8pZu3bH558FaBA79
         WjqKOKIri6RNhHsoFVI0dFUdhQFJawItgRA2t+w69jwwZwqTUERtOE0CAwVma7k/iQFN
         1Fl+KdrhZuK0lvC7ipmQsiEARFwUF+WoQlxmOCT/PvRdrIO6rPEWbGxfAWmQwA/o5y1A
         OJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774754755; x=1775359555;
        h=to:cc:date:message-id:subject:mime-version:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3zHZR2nqCQ4BfQwwL3YtsGWqRQDle8jBml0c4WJz+U=;
        b=eGfzJYLWbu0w1Qft97UkTy9Iyj8OqoTPq36SzopDHnCOdnYhS3r1SQAofO8qoZAG3H
         BGyKSmJi3Qizu1g6KHDOWfudkTdRCPSE4cr96PExqq68Lsj0OB2d+GW2cGpDPBARaGGf
         HJoXHzTmbbu4QD+okjvji7eoJ9+uZhXXyU/tIOKUI0V+UjxBpVo4e89BcUJNEzW5Vcfi
         cAtDgp7xOx3wPGqyPqeax3YF2sUJBCMeu87TrH6i2OazPDjxrDe/C2nk/cxU95lJX5mA
         xxNImh6iKl7CRsh3di5SIGfESg5ejuxZOA9sc10Mbe5R5pWDQ0KkIeYZd+dcdMLDbsof
         zSeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuNxjL0EkclRTnuy79dGjXyma3zMDbbAxJu3ezEX2Vypqrt6/3srGrirKokZ9oK0kGca5V5dk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+wk/yfjRO1zm8rH9SiFBiYKiwQLARkoEa72Dps15tARyZPgv9
	KML2VjJRr3hCdpx2/4u9zUZdS8wRkhItfy2+AGgBVfAqThrgoBrJ94aNlt4NiXMN6+8=
X-Gm-Gg: ATEYQzxMRzDmG4z8wrRGLAi2WxmQ60x2rH9hP119d2hI9nwh+CbW/FggGk0XjdCTGDZ
	TEeWpB6Mzf0E1B25D4bsU2Bc8W4A8rAX96T5Q7Fx2x5kQO0jCZAG9v01YU7uglH2GaZnIwwLDtY
	pVee4HtWKhZUcrTpbg0pZPN5BYn9RBpynV2ZkzfS/iCYjvKjrQQ0lx6ye3/IpLNX5W0x6fJhqjD
	u7r9J25ERW2175gV+Chd+52ccG/jFnQAZHr6SqRk3mWIf1oB5RfnZfjKkOfF+kMzvq4ksNKR84g
	IRznA9GBMAbHfzLL0Ix35b6DzuPECN0Qwv7RdzcAdr2Lram6PiJOp8DV2djKcuouIkbR5rfXVy6
	6BxApqepUaJ7WEpEzYRkD5ZhF3K9luANNlog632l4VnVWlJups9Z9Kr6seXdOvSChVeyhvOr2+I
	rTfbrSSTrOAb+Dg6Tw6XJ8LMPmmoKNAtmeyye8Ae88zPXeEghGpJlyfxVHFOKXjQVQiYOrHf7/o
	w==
X-Received: by 2002:a05:6808:1928:b0:467:5571:7f3c with SMTP id 5614622812f47-46a8a38f139mr3576274b6e.6.1774754754796;
        Sat, 28 Mar 2026 20:25:54 -0700 (PDT)
Received: from smtpclient.apple (c-76-16-6-204.hsd1.il.comcast.net. [76.16.6.204])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46aa0efdb75sm2191961b6e.13.2026.03.28.20.25.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2026 20:25:53 -0700 (PDT)
From: Bob Van Valzah <bob@vanvalzah.com>
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_DAE5922D-DCB8-444B-BD9A-99F8AE183AD2"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: [PATCH] igc: fix Tx timestamp timeout caused by unlocked TIMINCA
 write in adj fine
Message-Id: <D1C3B3DF-960F-40C7-BBD7-994359F0C8AD@vanvalzah.com>
Date: Sat, 28 Mar 2026 22:25:41 -0500
Cc: anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org,
 julianstj@fb.com,
 jeff@jeffgeerling.com
To: intel-wired-lan@lists.osuosl.org
X-Mailer: Apple Mail (2.3864.400.21)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[vanvalzah-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-python-script];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[vanvalzah-com.20230601.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TAGGED_FROM(0.00)[bounces-272848-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DMARC_NA(0.00)[vanvalzah.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bob@vanvalzah.com,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	APPLE_MAILER_COMMON(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 3FD73350927
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--Apple-Mail=_DAE5922D-DCB8-444B-BD9A-99F8AE183AD2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi,

We found a race in igc_ptp_adjfine_i225() that causes "Tx timestamp
timeout" errors and eventually wedges EXTTS when a PTP grandmaster
(ptp4l with hardware timestamping) runs concurrently with PHC
frequency discipline (any GPSDO calling clock_adjtime ADJ_FREQUENCY).

Root cause: igc_ptp_adjfine_i225() writes IGC_TIMINCA without holding
any lock.  Every other PTP clock operation in igc_ptp.c (adjtime,
gettime, settime) holds tmreg_lock, but adjfine does not.  When the
increment rate changes while the hardware is capturing a TX timestamp,
the captured value is corrupt.  The driver retries for
IGC_PTP_TX_TIMEOUT (15s), then logs the timeout and frees the skb.
Repeated occurrences eventually prevent EXTTS from delivering events.

The attached reproducer (triggers in ~17 seconds on i226):

  One thread calling clock_adjtime(ADJ_FREQUENCY) at ~200k/s on the
  PHC, another sending UDP packets with SO_TIMESTAMPING requesting
  hardware TX timestamps at ~100k/s.  A Python reproducer is at:
  =
https://github.com/bobvan/PePPAR-Fix/blob/main/tools/igc_tx_timeout_repro.=
py

  At realistic rates (1 Hz adjfine from a GPSDO + ptp4l at 128 Hz
  sync), the race triggers in ~30 minutes.

The attached patch holds ptp_tx_lock around the TIMINCA write and
skips the write if any TX timestamps are pending (tx_tstamp[i].skb
!=3D NULL), returning -EBUSY.  This doesn't fully close the hardware
race (a new TX capture can start between the check and the write),
but at realistic rates the residual probability gives ~25 year MTBF
vs ~30 minutes without the patch.

A complete fix would likely require either disabling TX timestamping
around TIMINCA writes (via TSYNCTXCTL), or making the timeout recovery
path more robust so a single corrupt timestamp doesn't wedge the
subsystem.  We'd welcome guidance from the igc maintainers on the
preferred approach.

Tested on:
  - Intel i226 (TimeHAT v5 board on Raspberry Pi 5)
  - Kernel 6.12.62+rpt-rpi-2712 (Raspberry Pi OS)
  - Intel out-of-tree igc driver 5.4.0-7642.46
  - Stock upstream igc_ptp.c (same code, same bug)

	Bob

---

 drivers/net/ethernet/intel/igc/igc_ptp.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c =
b/drivers/net/ethernet/intel/igc/igc_ptp.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -47,8 +47,10 @@ static int igc_ptp_adjfine_i225(struct ptp_clock_info =
*ptp, long scaled_ppm)
 {
        struct igc_adapter *igc =3D container_of(ptp, struct =
igc_adapter,
                                               ptp_caps);
        struct igc_hw *hw =3D &igc->hw;
+       unsigned long flags;
        int neg_adj =3D 0;
        u64 rate;
        u32 inca;
+       int i;

        if (scaled_ppm < 0) {
                neg_adj =3D 1;
@@ -63,7 +65,21 @@ static int igc_ptp_adjfine_i225(struct ptp_clock_info =
*ptp, long scaled_ppm)
        if (neg_adj)
                inca |=3D ISGN;

-       wr32(IGC_TIMINCA, inca);
+       /* Changing the clock increment rate while a TX timestamp is =
being
+        * captured by the hardware can corrupt the timestamp, causing =
the
+        * driver to report "Tx timestamp timeout" and eventually =
wedging
+        * the EXTTS subsystem.  Serialize with pending TX timestamps:
+        * skip the rate change if any are in flight.
+        */
+       spin_lock_irqsave(&igc->ptp_tx_lock, flags);
+       for (i =3D 0; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
+               if (igc->tx_tstamp[i].skb) {
+                       spin_unlock_irqrestore(&igc->ptp_tx_lock, =
flags);
+                       return -EBUSY;
+               }
+       }
+       wr32(IGC_TIMINCA, inca);
+       spin_unlock_irqrestore(&igc->ptp_tx_lock, flags);

        return 0;
 }
--
2.39.2

--Apple-Mail=_DAE5922D-DCB8-444B-BD9A-99F8AE183AD2
Content-Disposition: attachment;
	filename=igc_tx_timeout_repro.py
Content-Type: text/x-python-script;
	x-unix-mode=0644;
	name="igc_tx_timeout_repro.py"
Content-Transfer-Encoding: quoted-printable

#!/usr/bin/env python3
"""Reproducer for igc driver Tx timestamp timeout bug.

The igc driver (Intel i225/i226) has a race between clock_adjtime
(ADJ_FREQUENCY) and hardware TX timestamping.  When adjfine() is
called while a TX timestamp is pending, the timestamp register can
wedge, producing "Tx timestamp timeout" errors in dmesg and eventually
breaking EXTTS (PPS capture).

This reproducer runs two threads:
  1. Hammers clock_adjtime(ADJ_FREQUENCY) on the PHC
  2. Sends UDP packets with SO_TIMESTAMPING (hardware TX timestamps)

On a vulnerable igc driver, "Tx timestamp timeout" appears in dmesg
within seconds.

Usage:
    sudo python3 tools/igc_tx_timeout_repro.py eth1 /dev/ptp0
    # Watch with: dmesg -w | grep "Tx timestamp"

Requires root for SO_TIMESTAMPING and clock_adjtime on PHC.
"""

import ctypes
import ctypes.util
import os
import socket
import struct
import sys
import threading
import time


def get_phc_clockid(fd):
    return (~fd << 3) | 3


def adjfine_loop(phc_fd, stop_event, stats):
    """Hammer adjfine() on the PHC."""
    librt =3D ctypes.CDLL(ctypes.util.find_library("rt"), =
use_errno=3DTrue)

    class Timeval(ctypes.Structure):
        _fields_ =3D [("tv_sec", ctypes.c_long), ("tv_usec", =
ctypes.c_long)]

    class Timex(ctypes.Structure):
        _fields_ =3D [
            ("modes", ctypes.c_uint),
            ("offset", ctypes.c_long),
            ("freq", ctypes.c_long),
            ("maxerror", ctypes.c_long),
            ("esterror", ctypes.c_long),
            ("status", ctypes.c_int),
            ("constant", ctypes.c_long),
            ("precision", ctypes.c_long),
            ("tolerance", ctypes.c_long),
            ("time", Timeval),
            ("tick", ctypes.c_long),
            ("ppsfreq", ctypes.c_long),
            ("jitter", ctypes.c_long),
            ("shift", ctypes.c_int),
            ("stabil", ctypes.c_long),
            ("jitcnt", ctypes.c_long),
            ("calcnt", ctypes.c_long),
            ("errcnt", ctypes.c_long),
            ("stbcnt", ctypes.c_long),
            ("tai", ctypes.c_int),
        ]

    ADJ_FREQUENCY =3D 0x0002
    clockid =3D get_phc_clockid(phc_fd)
    n =3D 0
    toggle =3D False

    while not stop_event.is_set():
        tx =3D Timex()
        tx.modes =3D ADJ_FREQUENCY
        # Alternate between two tiny frequency offsets
        tx.freq =3D 100 if toggle else -100  # ~0.0015 ppb
        toggle =3D not toggle
        ret =3D librt.clock_adjtime(ctypes.c_int32(clockid), =
ctypes.byref(tx))
        if ret < 0:
            print(f"adjfine error: {ctypes.get_errno()}")
            break
        n +=3D 1

    stats["adjfine_count"] =3D n


def tx_timestamp_loop(iface, stop_event, stats):
    """Send UDP packets requesting hardware TX timestamps."""
    # SOL_SOCKET options for timestamping
    SO_TIMESTAMPING =3D 37
    SOF_TIMESTAMPING_TX_HARDWARE =3D (1 << 0)
    SOF_TIMESTAMPING_RAW_HARDWARE =3D (1 << 6)
    SOF_TIMESTAMPING_OPT_TSONLY =3D (1 << 11)

    flags =3D (SOF_TIMESTAMPING_TX_HARDWARE |
             SOF_TIMESTAMPING_RAW_HARDWARE |
             SOF_TIMESTAMPING_OPT_TSONLY)

    sock =3D socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.setsockopt(socket.SOL_SOCKET, SO_TIMESTAMPING, flags)
    # Bind to the specific interface
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_BINDTODEVICE,
                    iface.encode() + b'\0')
    sock.settimeout(0.01)

    # Send to a harmless destination (localhost or broadcast)
    dest =3D ("224.0.0.1", 9999)  # multicast, won't route
    payload =3D b"igc_repro" + b"\x00" * 32
    n =3D 0
    errors =3D 0

    while not stop_event.is_set():
        try:
            sock.sendto(payload, dest)
            n +=3D 1
        except OSError:
            errors +=3D 1
        # Don't sleep =E2=80=94 maximize collision probability
        # But yield to avoid starving the adjfine thread
        if n % 100 =3D=3D 0:
            time.sleep(0.0001)

    sock.close()
    stats["tx_count"] =3D n
    stats["tx_errors"] =3D errors


def check_dmesg_for_timeout():
    """Check if Tx timestamp timeout appeared in dmesg."""
    try:
        import subprocess
        result =3D subprocess.run(
            ["dmesg", "--since", "60 seconds ago"],
            capture_output=3DTrue, text=3DTrue, timeout=3D2
        )
        return "Tx timestamp timeout" in result.stdout
    except Exception:
        return False


def main():
    if len(sys.argv) < 3:
        print(f"Usage: sudo {sys.argv[0]} <interface> <ptp_device>")
        print(f"Example: sudo {sys.argv[0]} eth1 /dev/ptp0")
        sys.exit(1)

    iface =3D sys.argv[1]
    ptp_dev =3D sys.argv[2]
    duration =3D float(sys.argv[3]) if len(sys.argv) > 3 else 30.0

    if os.geteuid() !=3D 0:
        print("ERROR: must run as root (sudo)")
        sys.exit(1)

    phc_fd =3D os.open(ptp_dev, os.O_RDWR)
    print(f"Opened {ptp_dev} (fd=3D{phc_fd})")
    print(f"Interface: {iface}")
    print(f"Duration: {duration}s")
    print(f"Watch for: dmesg -w | grep 'Tx timestamp timeout'")
    print()

    stop =3D threading.Event()
    stats =3D {}

    t_adj =3D threading.Thread(target=3Dadjfine_loop, args=3D(phc_fd, =
stop, stats))
    t_tx =3D threading.Thread(target=3Dtx_timestamp_loop, args=3D(iface, =
stop, stats))

    t_adj.start()
    t_tx.start()

    start =3D time.monotonic()
    triggered =3D False
    while time.monotonic() - start < duration:
        time.sleep(1)
        elapsed =3D time.monotonic() - start
        if check_dmesg_for_timeout():
            print(f"\n*** Tx timestamp timeout detected after =
{elapsed:.1f}s ***")
            triggered =3D True
            break
        print(f"  {elapsed:.0f}s: running...", end=3D"\r")

    stop.set()
    t_adj.join(timeout=3D2)
    t_tx.join(timeout=3D2)
    os.close(phc_fd)

    adj_n =3D stats.get("adjfine_count", 0)
    tx_n =3D stats.get("tx_count", 0)
    tx_err =3D stats.get("tx_errors", 0)
    elapsed =3D time.monotonic() - start

    print(f"\nResults ({elapsed:.1f}s):")
    print(f"  adjfine calls: {adj_n} ({adj_n/elapsed:.0f}/s)")
    print(f"  TX packets:    {tx_n} ({tx_n/elapsed:.0f}/s), {tx_err} =
errors")

    if triggered:
        print(f"\n  BUG TRIGGERED: igc Tx timestamp timeout")
        print(f"  The igc driver's PTP timestamp register wedged due =
to")
        print(f"  concurrent adjfine() and hardware TX timestamping.")
        sys.exit(1)
    else:
        print(f"\n  No timeout detected in {duration}s")
        sys.exit(0)


if __name__ =3D=3D "__main__":
    main()

--Apple-Mail=_DAE5922D-DCB8-444B-BD9A-99F8AE183AD2--

