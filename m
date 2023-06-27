Return-Path: <netdev+bounces-14304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 146087400C8
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 18:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4DEE280CB8
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 16:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ACF19E65;
	Tue, 27 Jun 2023 16:21:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2630419E40
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 16:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30CDC433C8;
	Tue, 27 Jun 2023 16:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687882908;
	bh=1YWRKhqL0VHrYi2Uqzx4h/pJ+QpTyDMDcAktQeLbc/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FzQHyKJ86E7/lUHSbrjGbzBVfZ5+R2O+oW+AZRPgP4ZoSEEveNRygd9k2H+z2a9eP
	 d2BqClGBcC6JZzsdBxjPo7OZUnAcEnk5UjurTwEQr3UlLKqkiRN+wrDaPBM8k/M3IW
	 3X+EHPKPBhk1XM/l5LKOVGM5iX8BFyoC9S/4qD7KWj25k+fLGdthvC/JhY5xlfeAwg
	 kWk/4m8Ptkbg95RiiF+bO3SOvD40VJ1/BR3JDMrU9IBq533mu6npO1S46xipLQGbUv
	 iog5w3je5EBBfGjZqvGkF8Ow2YQ5OTEuTqAKhgjJf6DSedGbjT7og39E442rlIoEbU
	 Cwr5ZMm7sTLzQ==
Date: Tue, 27 Jun 2023 09:21:46 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Saeed Mahameed <saeed@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Shuah Khan <shuah@kernel.org>,
	Maciek Machnikowski <maciek@machnikowski.net>
Subject: Re: [PATCH v3 5/9] ptp: Add .getmaxphase callback to ptp_clock_info
Message-ID: <20230627162146.GA114473@dev-arch.thelio-3990X>
References: <20230612211500.309075-1-rrameshbabu@nvidia.com>
 <20230612211500.309075-6-rrameshbabu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230612211500.309075-6-rrameshbabu@nvidia.com>

Hi Rahul,

On Mon, Jun 12, 2023 at 02:14:56PM -0700, Rahul Rameshbabu wrote:
> Enables advertisement of the maximum offset supported by the phase control
> functionality of PHCs. The callback is used to return an error if an offs=
et
> not supported by the PHC is used in ADJ_OFFSET. The ioctls
> PTP_CLOCK_GETCAPS and PTP_CLOCK_GETCAPS2 now advertise the maximum offset=
 a
> PHC's phase control functionality is capable of supporting. Introduce new
> sysfs node, max_phase_adjustment.
>=20
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Maciek Machnikowski <maciek@machnikowski.net>
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Acked-by: Richard Cochran <richardcochran@gmail.com>

<snip>

> diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
> index f30b0a439470..77219cdcd683 100644
> --- a/drivers/ptp/ptp_sysfs.c
> +++ b/drivers/ptp/ptp_sysfs.c
> @@ -18,6 +18,17 @@ static ssize_t clock_name_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(clock_name);
> =20
> +static ssize_t max_phase_adjustment_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *page)
> +{
> +	struct ptp_clock *ptp =3D dev_get_drvdata(dev);
> +
> +	return snprintf(page, PAGE_SIZE - 1, "%d\n",
> +			ptp->info->getmaxphase(ptp->info));

I am seeing a crash when accessing this sysfs node, which I initially
found by running LTP's read_all test case.

# cat /sys/class/ptp/ptp0/max_phase_adjustment
fish: Job 1, 'cat /sys/class/ptp/ptp0/max_pha=E2=80=A6' terminated by signa=
l SIGKILL (Forced quit)

# dmesg
[  133.104459] BUG: kernel NULL pointer dereference, address: 0000000000000=
000
[  133.104472] #PF: supervisor instruction fetch in kernel mode
[  133.104478] #PF: error_code(0x0010) - not-present page
[  133.104483] PGD 0 P4D 0=20
[  133.104490] Oops: 0010 [#2] PREEMPT SMP NOPTI
[  133.104498] CPU: 13 PID: 2705 Comm: cat Tainted: G      D            6.4=
=2E0-rc6-debug-01344-gc3b60ab7a4df #1 d68962f26eeefb0e64d3dd104c3eef4a1ac5b=
0d5
[  133.104508] Hardware name: ASUS System Product Name/PRIME Z590M-PLUS, BI=
OS 1203 10/27/2021
[  133.104512] RIP: 0010:0x0
[  133.104563] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  133.104567] RSP: 0018:ffffbc38c5e2fdb8 EFLAGS: 00010286
[  133.104574] RAX: 0000000000000000 RBX: ffff9e3fc8e62000 RCX: ffffffffbb3=
86100
[  133.104579] RDX: ffff9e3fc8e62000 RSI: ffffffffbb386100 RDI: ffff9e3fc43=
ef968
[  133.104583] RBP: ffffffffba7795b0 R08: ffff9e3fd106c0f0 R09: ffff9e3fd10=
418c0
[  133.104587] R10: ffff9e3fc8e62000 R11: 0000000000000000 R12: ffffbc38c5e=
2fe88
[  133.104590] R13: ffffbc38c5e2fe60 R14: 0000000000000001 R15: ffffbc38c5e=
2fef8
[  133.104594] FS:  00007f24dc5e5740(0000) GS:ffff9e46ff740000(0000) knlGS:=
0000000000000000
[  133.104600] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  133.104605] CR2: ffffffffffffffd6 CR3: 0000000104352001 CR4: 00000000007=
70ee0
[  133.104610] PKRU: 55555554
[  133.104613] Call Trace:
[  133.104617]  <TASK>
[  133.104622]  ? __die+0x23/0x70
[  133.104632]  ? page_fault_oops+0x171/0x4e0
[  133.104641]  ? exc_page_fault+0x7f/0x180
[  133.104649]  ? asm_exc_page_fault+0x26/0x30
[  133.104662]  ? seq_read_iter+0x375/0x480
[  133.104670]  max_phase_adjustment_show+0x1e/0x40
[  133.104680]  dev_attr_show+0x19/0x60
[  133.104692]  sysfs_kf_seq_show+0xa8/0x100
[  133.104703]  seq_read_iter+0x120/0x480
[  133.104711]  vfs_read+0x1f3/0x320
[  133.104721]  ksys_read+0x6f/0xf0
[  133.104730]  do_syscall_64+0x5d/0x90
[  133.104741]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  133.104750] RIP: 0033:0x7f24dc6e1b21
[  133.104763] Code: c5 fe ff ff 50 48 8d 3d 25 7d 0a 00 e8 e8 11 02 00 0f =
1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d dd 99 0e 00 00 74 13 31 c0 0f 05 <48=
> 3d 00 f0 ff ff 77 57 c3 66 0f 1f 44 00 00 48 83 ec 28 48 89 54
[  133.104769] RSP: 002b:00007ffea4af1b88 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000000
[  133.104776] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f24dc6=
e1b21
[  133.104780] RDX: 0000000000020000 RSI: 00007f24dc5c4000 RDI: 00000000000=
00003
[  133.104784] RBP: 0000000000020000 R08: 00000000ffffffff R09: 00000000000=
00000
[  133.104788] R10: 0000000000000022 R11: 0000000000000246 R12: 00007f24dc5=
c4000
[  133.104792] R13: 0000000000000003 R14: 0000000000020000 R15: 00000000000=
00000
[  133.104799]  </TASK>
[  133.104801] Modules linked in: overlay xt_mark snd_seq_dummy snd_hrtimer=
 snd_seq snd_seq_device tun hid_logitech_hidpp mousedev joydev xt_CHECKSUM =
xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp nft_compat n=
ft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nf=
netlink bridge stp llc hid_logitech_dj hid_razer snd_hda_codec_hdmi snd_hda=
_codec_realtek snd_hda_codec_generic vfat fat snd_sof_pci_intel_tgl snd_sof=
_intel_hda_common snd_soc_hdac_hda snd_sof_pci snd_sof_xtensa_dsp snd_sof_i=
ntel_hda_mlink intel_rapl_msr snd_sof_intel_hda intel_rapl_common i915 snd_=
sof snd_sof_utils snd_hda_ext_core x86_pkg_temp_thermal snd_soc_acpi_intel_=
match intel_powerclamp snd_soc_acpi coretemp snd_soc_core kvm_intel i2c_alg=
o_bit snd_compress drm_buddy snd_hda_intel kvm snd_intel_dspcfg eeepc_wmi i=
ntel_gtt irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul snd_hda=
_codec asus_wmi polyval_clmulni mei_hdcp polyval_generic snd_hwdep ledtrig_=
audio mei_pxp iTCO_wdt gf128mul drm_kms_helper
[  133.104921]  ghash_clmulni_intel sparse_keymap intel_pmc_bxt snd_hda_cor=
e sha512_ssse3 syscopyarea platform_profile iTCO_vendor_support rfkill ee10=
04 aesni_intel wmi_bmof crypto_simd cryptd snd_pcm sysfillrect intel_cstate=
 sysimgblt mei_me snd_timer spi_nor intel_uncore i2c_i801 e1000e snd intel_=
lpss_pci cec mtd pcspkr mei intel_lpss soundcore i2c_smbus ttm idma64 video=
 wmi acpi_tad acpi_pad usbhid mac_hid pkcs8_key_parser dm_multipath drm cry=
pto_user fuse dm_mod loop zram bpf_preload ip_tables x_tables nvme spi_inte=
l_pci nvme_core xhci_pci spi_intel xhci_pci_renesas nvme_common btrfs blake=
2b_generic libcrc32c crc32c_generic crc32c_intel xor raid6_pq
[  133.105024] CR2: 0000000000000000
[  133.105029] ---[ end trace 0000000000000000 ]---
[  133.105033] RIP: 0010:0x0
[  133.105046] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[  133.105049] RSP: 0018:ffffbc38c5aafce0 EFLAGS: 00010286
[  133.105054] RAX: 0000000000000000 RBX: ffff9e3ffdfe5000 RCX: ffffffffbb3=
86100
[  133.105058] RDX: ffff9e3ffdfe5000 RSI: ffffffffbb386100 RDI: ffff9e3fc43=
ef968
[  133.105062] RBP: ffffffffba7795b0 R08: ffff9e3fd106c0f0 R09: ffff9e3fc4d=
8fc80
[  133.105065] R10: ffff9e3ffdfe5000 R11: 0000000000000000 R12: ffffbc38c5a=
afdb0
[  133.105069] R13: ffffbc38c5aafd88 R14: 0000000000000001 R15: ffffbc38c5a=
afe20
[  133.105072] FS:  00007f24dc5e5740(0000) GS:ffff9e46ff740000(0000) knlGS:=
0000000000000000
[  133.105077] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  133.105081] CR2: ffffffffffffffd6 CR3: 0000000104352001 CR4: 00000000007=
70ee0
[  133.105085] PKRU: 55555554
[  133.105088] note: cat[2705] exited with irqs disabled

This was also reported at [1], I apologize for the duplicate report but
it does not seem like there has been any movement on this from what I
can tell.

If there is any additional information I can provide or patches I can
test, please let me know.

> +}
> +static DEVICE_ATTR_RO(max_phase_adjustment);
> +
>  #define PTP_SHOW_INT(name, var)						\
>  static ssize_t var##_show(struct device *dev,				\
>  			   struct device_attribute *attr, char *page)	\
> @@ -309,6 +320,7 @@ static struct attribute *ptp_attrs[] =3D {
>  	&dev_attr_clock_name.attr,
> =20
>  	&dev_attr_max_adjustment.attr,
> +	&dev_attr_max_phase_adjustment.attr,
>  	&dev_attr_n_alarms.attr,
>  	&dev_attr_n_external_timestamps.attr,
>  	&dev_attr_n_periodic_outputs.attr,

[1]: https://lore.kernel.org/89dfc918-9757-4487-aa72-615f7029f6c1@app.fastm=
ail.com/

Cheers,
Nathan

