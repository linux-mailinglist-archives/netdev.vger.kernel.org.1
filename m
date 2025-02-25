Return-Path: <netdev+bounces-169442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF6CA43F53
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 13:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6E219C4541
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F248D26868B;
	Tue, 25 Feb 2025 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXEe8cEa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B7E268685
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740485950; cv=none; b=vDO501WGoVKWU4wny9/tK5dmgnhVl1IPxLrtdTzVkK/I9k8IAv3aJWXvBK4lukodVCSNeDt6Fny9vB5vC1cfVrYx9/zH8rHtFaVmsPoMCfHKt+1V63O/TnGXxlov9fILtE5jin+4LkocNgs9OIH0/3qwGxvwwajudULOshlf8X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740485950; c=relaxed/simple;
	bh=cpI0VBK2sextWejCJ/uxccxRMT5Kg6tyghsi/kT+2G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icSg+Ik9P9+Qp+pMQd070jJsNcYU936rvQI1sdsOTloToNiwWiHEES6MRRg4wNqrR2J1/D3WYfHLZoTTJ2BGkuTnZSrSlNq+MCbelwEVR871SqLTfiu7UfwC6f0R3xn8eViic8hW/91Sp7OKBEblqJq6fh9PPNSTZUEWUxlEHcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EXEe8cEa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740485947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+6Xv32fpzPAFxIs8eVTle+ApSi4xdX1GdVExg4VgFds=;
	b=EXEe8cEagY9bcmLYvjqVnGiI7R1iHm8mWnHicIWI+x8cStg7C6ksyRPdKpWpo6mrmknv2i
	GkMGpLcuCOYaAihx9e0gEY5MeZdAzRdhtl0A5ROldLezNaIlUQ8NY8zPuEV7txNNwXCD37
	cLfaFGtPLLDdXMD7e7BJP1t2eLYLoVA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-L7LdFtugPKy8oYiskctlOQ-1; Tue, 25 Feb 2025 07:19:06 -0500
X-MC-Unique: L7LdFtugPKy8oYiskctlOQ-1
X-Mimecast-MFC-AGG-ID: L7LdFtugPKy8oYiskctlOQ_1740485945
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4399a5afc72so28448345e9.3
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 04:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740485945; x=1741090745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6Xv32fpzPAFxIs8eVTle+ApSi4xdX1GdVExg4VgFds=;
        b=QKqvkBMzKoJogzO1xcTVqcmRDlUjymMMWIJ9RCA7k05+CQ5mlHqGscOBYtJEV3Ha+u
         wa4Az7EGHucg1+z59ipRDL5UeVFTlZhQKz204jqqmWMDcgrFCJe7AWivQT5xS+0fOiby
         tCzemIMZ1Lrd81IKloTDCCReXW7hZ6/uLRy4iywbOtPjbIWuulf5IGZZfdOgfK1A4fz8
         A6x+C6DOEUzO4yz9+bi3j+VygN52hlaPgU8WMxO9px9tEwwGLRi68at7gtraUTfLBPYK
         +Gb4YGeW9YBdzvwy5vIFTuba4TlROSMw9oKSn3DPx17TvebkSP4PyiIT89F9WTeJbBVU
         JutA==
X-Forwarded-Encrypted: i=1; AJvYcCXteZdPu27RO41Z0MXN8Asg7pV1A0QdxSUggx/qk81UgjkkgMDQUyNq8vQ9HuGmiemRWs5xPUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoedWLgBUdkBJ9AjQxpTfKn+30NNUn9u8GNkLBO2IfRqmGdKjh
	K+ZMG1sSHVCoTn70Gybm6j17M8k0Ptb/eFbChmoSxLMqln1PdL2R4O+tm4E8jpp2x1iU/4llnl7
	sISS7sK4kWVNEvquKbIc7l17thEkdwtCplWdmeSotbAN5mP622G2H1A==
X-Gm-Gg: ASbGncuF5r4jHx8uXckz6cVGzDT/HSE1mkCmP71nOOJMLAr+NnOJXxAge86KJiu9o0Q
	SeMpaaIzvaQjeu1b3dxxFoTAyDe82+jhB/KY403nV1+kSOKOuAF+E0Asi2CTGV6cWVvLuGWUY6Y
	RRTkJV6bKSXUHDAVmap+bXreIcgjlmcv0147JejcjlPqRxq+ikQSmUvlxkh40o3WR++nyfyxcWQ
	DwTRXuvdwGS5ddeHWcAbLNTTmzkp82GeGxUmQLlRNjPPLvmklmkkRclJpf/eeGABZOoxhlQRFEJ
X-Received: by 2002:a05:600c:3548:b0:439:a138:1d with SMTP id 5b1f17b1804b1-439aebc2408mr119025195e9.22.1740485944817;
        Tue, 25 Feb 2025 04:19:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJNn+UVhAJ4A3syB6Q9pLkR4WVlbYJdB9JUI17lX408kyI27LeJtVU1nz/Y3zTm7YpggCDJw==
X-Received: by 2002:a05:600c:3548:b0:439:a138:1d with SMTP id 5b1f17b1804b1-439aebc2408mr119024785e9.22.1740485944250;
        Tue, 25 Feb 2025 04:19:04 -0800 (PST)
Received: from redhat.com ([2.52.7.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab1539dc0sm24202915e9.9.2025.02.25.04.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 04:19:03 -0800 (PST)
Date: Tue, 25 Feb 2025 07:18:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Hilber <quic_philber@quicinc.com>
Cc: Jason Wang <jasowang@redhat.com>, Trilok Soni <quic_tsoni@quicinc.com>,
	Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	David Woodhouse <dwmw2@infradead.org>,
	"Ridoux, Julien" <ridouxj@amazon.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Parav Pandit <parav@nvidia.com>,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v5 0/4] Add virtio_rtc module
Message-ID: <20250225071748-mutt-send-email-mst@kernel.org>
References: <20250219193306.1045-1-quic_philber@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219193306.1045-1-quic_philber@quicinc.com>

On Wed, Feb 19, 2025 at 08:32:55PM +0100, Peter Hilber wrote:
> This series implements a driver for a virtio-rtc device conforming to spec
> proposal v7 [1]. It includes a PTP clock driver and an RTC class driver
> with alarm.
> 
> v5 updates
> ==========
> 
> Important changes compared to the previous driver series [3] are:
> 
> - Update to spec proposal v7 [1].
> 
> - Fix multiple initialization related bugs.
> 
> - Drop the RFC tag, since no major outstanding issues are apparent.
> 
> Overview
> ========
> 
> This patch series adds the virtio_rtc module, and related bugfixes. The
> virtio_rtc module implements a driver compatible with the proposed Virtio
> RTC device specification [1]. The Virtio RTC (Real Time Clock) device
> provides information about current time. The device can provide different
> clocks, e.g. for the UTC or TAI time standards, or for physical time
> elapsed since some past epoch. The driver can read the clocks with simple
> or more accurate methods. Optionally, the driver can set an alarm.
> 
> For the Virtio RTC device, there is currently a proprietary implementation,
> which has been used for testing.
> 
> PTP clock interface
> ===================
> 
> virtio_rtc exposes clocks as PTP clocks to userspace, similar to ptp_kvm.
> If both the Virtio RTC device and this driver have special support for the
> current clocksource, time synchronization programs can use
> cross-timestamping using ioctl PTP_SYS_OFFSET_PRECISE2 aka
> PTP_SYS_OFFSET_PRECISE. Similar to ptp_kvm, system time synchronization
> with single-digit ns precision is possible with a quiescent reference clock
> (from the Virtio RTC device). This works even when the Virtio device
> response is slow compared to ptp_kvm hypercalls.
> 
> The following illustrates a test using PTP_SYS_OFFSET_PRECISE, with
> interspersed strace log and chrony [2] refclocks log, on arm64. In the
> example, chrony tracks a virtio_rtc PTP clock ("PHCV", /dev/ptp0). The raw
> offset between the virtio_rtc clock and CLOCK_REALTIME is 0 to 1 ns. At the
> device side, the Virtio RTC device artificially delays both the clock read
> request, and the response, by 50 ms. Cross-timestamp interpolation still
> works with this delay. chrony also monitors a ptp_kvm clock ("PHCK",
> /dev/ptp3) for comparison, which yields a similar offset.
> 
> 	ioctl(5</dev/ptp3>, PTP_SYS_OFFSET_PRECISE, 0xffffe86691c8) = 0 <0.000329>
> 	===============================================================================
> 	   Date (UTC) Time         Refid  DP L P  Raw offset   Cooked offset      Disp.
> 	===============================================================================
> 	2023-06-29 18:49:55.595742 PHCK    0 N 0  1.000000e-09  8.717931e-10  5.500e-08
> 	2023-06-29 18:49:55.595742 PHCK    - N -       -        8.717931e-10  5.500e-08
> 	ioctl(6</dev/ptp0>, PTP_SYS_OFFSET_PRECISE, 0xffffe86691c8) = 0 <0.101545>
> 	2023-06-29 18:49:56.147766 PHCV    0 N 0  1.000000e-09  8.801870e-10  5.500e-08
> 	2023-06-29 18:49:56.147766 PHCV    - N -       -        8.801870e-10  5.500e-08
> 	ioctl(5</dev/ptp3>, PTP_SYS_OFFSET_PRECISE, 0xffffe86691c8) = 0 <0.000195>
> 	2023-06-29 18:49:56.202446 PHCK    0 N 0  1.000000e-09  7.364180e-10  5.500e-08
> 	2023-06-29 18:49:56.202446 PHCK    - N -       -        7.364180e-10  5.500e-08
> 	ioctl(6</dev/ptp0>, PTP_SYS_OFFSET_PRECISE, 0xffffe86691c8) = 0 <0.101484>
> 	2023-06-29 18:49:56.754641 PHCV    0 N 0  0.000000e+00 -2.617368e-10  5.500e-08
> 	2023-06-29 18:49:56.754641 PHCV    - N -       -       -2.617368e-10  5.500e-08
> 	ioctl(5</dev/ptp3>, PTP_SYS_OFFSET_PRECISE, 0xffffe86691c8) = 0 <0.000270>
> 	2023-06-29 18:49:56.809282 PHCK    0 N 0  1.000000e-09  7.779321e-10  5.500e-08
> 	2023-06-29 18:49:56.809282 PHCK    - N -       -        7.779321e-10  5.500e-08
> 	ioctl(6</dev/ptp0>, PTP_SYS_OFFSET_PRECISE, 0xffffe86691c8) = 0 <0.101510>
> 	2023-06-29 18:49:57.361376 PHCV    0 N 0  0.000000e+00 -2.198794e-10  5.500e-08
> 	2023-06-29 18:49:57.361376 PHCV    - N -       -       -2.198794e-10  5.500e-08
> 
> This patch series only adds special support for the Arm Generic Timer
> clocksource. At the driver side, it should be easy to support more
> clocksources.
> 
> Fallback PTP clock interface
> ----------------------------
> 
> Without special support for the current clocksource, time synchronization
> programs can still use ioctl PTP_SYS_OFFSET_EXTENDED2 aka
> PTP_SYS_OFFSET_EXTENDED. In this case, precision will generally be worse
> and will depend on the Virtio device response characteristics.
> 
> The following illustrates a test using PTP_SYS_OFFSET_EXTENDED, with
> interspersed strace log and chrony refclocks log, on x86-64 (with `ts'
> values omitted):
> 
> 	ioctl(5, PTP_SYS_OFFSET_EXTENDED, {n_samples=10, ts=OMITTED}) = 0
> 	===============================================================================
> 	   Date (UTC) Time         Refid  DP L P  Raw offset   Cooked offset      Disp.
> 	===============================================================================
> 	2023-06-28 14:11:26.697782 PHCV    0 N 0  3.318200e-05  3.450891e-05  4.611e-06
> 	2023-06-28 14:11:26.697782 PHCV    - N -       -        3.450891e-05  4.611e-06
> 	ioctl(5, PTP_SYS_OFFSET_EXTENDED, {n_samples=10, ts=OMITTED}) = 0
> 	2023-06-28 14:11:27.208763 PHCV    0 N 0 -3.792800e-05 -4.023965e-05  4.611e-06
> 	2023-06-28 14:11:27.208763 PHCV    - N -       -       -4.023965e-05  4.611e-06
> 	ioctl(5, PTP_SYS_OFFSET_EXTENDED, {n_samples=10, ts=OMITTED}) = 0
> 	2023-06-28 14:11:27.722818 PHCV    0 N 0 -3.328600e-05 -3.134404e-05  4.611e-06
> 	2023-06-28 14:11:27.722818 PHCV    - N -       -       -3.134404e-05  4.611e-06
> 	ioctl(5, PTP_SYS_OFFSET_EXTENDED, {n_samples=10, ts=OMITTED}) = 0
> 	2023-06-28 14:11:28.233572 PHCV    0 N 0 -4.966900e-05 -4.584331e-05  4.611e-06
> 	2023-06-28 14:11:28.233572 PHCV    - N -       -       -4.584331e-05  4.611e-06
> 	ioctl(5, PTP_SYS_OFFSET_EXTENDED, {n_samples=10, ts=OMITTED}) = 0
> 	2023-06-28 14:11:28.742737 PHCV    0 N 0  4.902700e-05  5.361388e-05  4.611e-06
> 	2023-06-28 14:11:28.742737 PHCV    - N -       -        5.361388e-05  4.611e-06
> 
> PTP clock setup
> ---------------
> 
> The following udev rule can be used to get a symlink /dev/ptp_virtio to the
> UTC clock:
> 
> 	SUBSYSTEM=="ptp", ATTR{clock_name}=="Virtio PTP type 0, variant 0", SYMLINK += "ptp_virtio"
> 
> The following chrony configuration directive can then be added in
> /etc/chrony/chrony.conf to synchronize to the Virtio UTC clock:
> 
> 	refclock PHC /dev/ptp_virtio refid PHCV poll -1 dpoll -1
> 
> RTC interface
> =============
> 
> This patch series adds virtio_rtc as a generic Virtio driver, including
> both a PTP clock driver and an RTC class driver.
> 
> Feedback is greatly appreciated.
> 
> [1] https://lore.kernel.org/virtio-comment/20250123101616.664-1-quic_philber@quicinc.com/
> [2] https://chrony.tuxfamily.org/
> [3] https://lore.kernel.org/lkml/20241219201118.2233-1-quic_philber@quicinc.com/
> 
> Changelog
> =========
> 
> v5:
> 
> - Update to virtio-rtc spec v7, essentially removing definitions.
> 
> - Fix multiple bugs after readying device during probe and restore.
> 
> - Actually initialize Virtio clock id for RTC class device.
> 
> - Add freeze/restore ops already in first patch.
> 
> - Minor changes:
> 
>   - Use new APIs devm_device_init_wakeup(), secs_to_jiffies().
> 
>   - Fix style issues.
> 
>   - Improve logging types and clarity.
> 
>   - Drop unnecessary memory barrier pair.
> 
>   - Return error status from device, whenever available.
> 
> v4:
> 
> - Update Virtio interface to spec v6.
> 
> - Distinguish UTC-like clocks by handling of leap seconds (spec v6).
> 
> - Do not create RTC class device for clocks which may step on leap seconds
>   (Alexandre Belloni).
> 
> - Clear RTC class feature bit instead of defining reduced ops
>   (Alexandre Belloni).
> 
> - For PTP clock name, always use numeric clock type, and numeric variant.
> 
> - Use macros for 64-bit divisions.
> 
> - Remove unnecessary memory barriers.
> 
> - Cosmetic improvements.
> 
> - Drop upstreamed timekeeping bugfixes from series.
> 
> v3:
> 
> - Update to conform to virtio spec RFC v3 (no significant behavioral
>   changes).
> 
> - Add RTC class driver with alarm according to virtio spec RFC v3.
> 
> - For cross-timestamp corner case fix, switch back to v1 style closed
>   interval test (Thomas Gleixner).
> 
> v2:
> 
> - Depend on patch series "treewide: Use clocksource id for
>   get_device_system_crosststamp()" to avoid requiring a clocksource pointer
>   with get_device_system_crosststamp().
> 
> - Assume Arm Generic Timer will use CP15 virtual counter. Drop
>   arm_arch_timer helper functions (Marc Zyngier).
> 
> - Improve cross-timestamp fixes problem description and implementation
>   (John Stultz).
> 
> 
> Peter Hilber (4):
>   virtio_rtc: Add module and driver core
>   virtio_rtc: Add PTP clocks
>   virtio_rtc: Add Arm Generic Timer cross-timestamping
>   virtio_rtc: Add RTC class driver
> 
>  MAINTAINERS                          |    7 +
>  drivers/virtio/Kconfig               |   64 ++
>  drivers/virtio/Makefile              |    5 +
>  drivers/virtio/virtio_rtc_arm.c      |   23 +
>  drivers/virtio/virtio_rtc_class.c    |  262 +++++
>  drivers/virtio/virtio_rtc_driver.c   | 1404 ++++++++++++++++++++++++++
>  drivers/virtio/virtio_rtc_internal.h |  122 +++
>  drivers/virtio/virtio_rtc_ptp.c      |  347 +++++++
>  include/uapi/linux/virtio_rtc.h      |  237 +++++


Also, should this driver live under
./drivers/rtc/virtio/

?



>  9 files changed, 2471 insertions(+)
>  create mode 100644 drivers/virtio/virtio_rtc_arm.c
>  create mode 100644 drivers/virtio/virtio_rtc_class.c
>  create mode 100644 drivers/virtio/virtio_rtc_driver.c
>  create mode 100644 drivers/virtio/virtio_rtc_internal.h
>  create mode 100644 drivers/virtio/virtio_rtc_ptp.c
>  create mode 100644 include/uapi/linux/virtio_rtc.h
> 
> 
> base-commit: 8936cec5cb6e27649b86fabf383d7ce4113bba49
> -- 
> 2.43.0


