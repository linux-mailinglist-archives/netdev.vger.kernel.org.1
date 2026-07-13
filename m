Return-Path: <netdev+bounces-307022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ATcpIFqKVGpCnAMAu9opvQ
	(envelope-from <netdev+bounces-307022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:48:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB3A747A91
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:48:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=korg header.b=Y72s5PcM;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307022-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307022-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93018301DBBE
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 06:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29496368D74;
	Mon, 13 Jul 2026 06:48:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EEA2989B5;
	Mon, 13 Jul 2026 06:48:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783925318; cv=none; b=IofRZC24JLVtUiGoFUrzxzJVsec4f/A03MZumh44GU0RkWbToNgiiyvzd+ugovJZy3MI9cSJu7pScl0PoYh2BLUANDkEVVBIO0uDOBc+RX5KHtGidQnVlWuzO/KgLphkKuoCw2+SWYliRF+fngXaaQsRnh7SyfEyLLvGJg1FRpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783925318; c=relaxed/simple;
	bh=OzkFDQ/lWEf+9BNyivIaDF4MnYniL+LTY2u8Ewnz8+Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VHjFgeYxtYExkPU60ngWDt93FNbfOatm0bDyMIxXTSOs/5ImurjNtKdhf8i1OHuV/gspm+rIGqTaxwOgvQgWo/5irO2pA7QNKQOfmJqaCzEewDnUfCfTx+QCrlTJMVPcqCjy50Hsq32GT6miQplvR5VSS733V/3vECIxKPd28G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y72s5PcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48B88C2BCC7;
	Mon, 13 Jul 2026 06:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1783925318; bh=OzkFDQ/lWEf+9BNyivIaDF4MnYniL+LTY2u8Ewnz8+Y=;
	h=From:Subject:Date:To:Cc:From;
	b=Y72s5PcMqQUjF7temIsZjuSY/61V7hyZ9Mqa6dBKSM4y7aV5W/YjuaDi+dMqxMFnq
	 i1uR8tvyN77sYPOU/oeyo5pmRNYjYeXPQjzgdUQeEkeBYoPBKAa7LrNdrgSta5bRFd
	 gsaDvtge1gZ89YHt45Xb2DEh7E35BcKMd37Xe5Rg=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308FDC43458;
	Mon, 13 Jul 2026 06:48:38 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Subject: [PATCH v8 00/10] Fix missing fops.owner in Rust DRM/misc
 abstractions
Date: Mon, 13 Jul 2026 14:45:21 +0800
Message-Id: <20260713-fix-fops-owner-v8-0-2495cfa82d47@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIKJVGoC/33Qy07DMBAF0F+JvMaVn3GdFf+BWPgxBkskKU5qi
 qr+O0MqQZQIlmP53Dv2lUxQMkyka66kQM1THgccjg8NCa9ueAGaI85EMNEyzS1N+ULTeJro+DF
 AoSCdMd4LE9pAEJ0K4I0l8On5Phd4P2PufD8k3k1Aw9j3ee6aag6clmDIuq9rftr6PIUIlZ7Rp
 LH0bqbWeQNH6XngvKuSfLe85mkey+fyisqXmr8WrpwyKiJEe5QsOq4e3/JwvhywZYmqYsUF33G
 BPEVrmbFBO7bj8pe3Quy4RK5sVDp4aZgUW67WXO64Qo5bJ52YMVGHLddrrnZcI3eOB++EEonpL
 W//5y1yLawGKSXuD1tu1tzsuEGOMEr8PYiJrfntdvsC/Zud1owCAAA=
X-Change-ID: 20260519-fix-fops-owner-e3a77bb27c6c
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Igor Korotin <igor.korotin@linux.dev>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-pci@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783925315; l=9411;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=OzkFDQ/lWEf+9BNyivIaDF4MnYniL+LTY2u8Ewnz8+Y=;
 b=83/QAu3uiAEI0OkJ0Sr0DWt+ATpxXnOntlbMkr/gsCrlomKyAPsBN1xQjvQQaoCeZL3VbJzp4
 N9JX/mDTCn1DDGtEshqILTcqkV3jMgcoq9j9kr+okfzNCg0svwmxpqg
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-307022-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[47];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,suse.com,atomlin.com,linuxfoundation.org,gmail.com,ffwll.ch,collabora.com,arndb.de,linux.dev,davidgow.net,debian.org,kernel.dk,intel.com,android.com];
	FORGED_RECIPIENTS(0.00)[m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:mcgrof@kernel.org,m:petr.pavlu@suse.com,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:atomlin@atomlin.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:daniel.almeida@collabora.com,m:arnd@arndb.de,m:brendan.higgins@linux.dev,m:david@davidgow.net,m:raemoar63@gmail.com,m:leitao@debian.org,m:axboe@kernel.dk,m:david.m.ertman@intel.com,m:leon@kernel.org,m:igor.korotin@linux.dev,m:fujita.tomonori@gmail.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:arve@android.com,m:tkjos@android.com,m:brauner@kernel.org,m:cmllamas@google.com,m:rust-for-linux@vger.kernel.org,m:linux-modules@vger.kernel.org,m:driver-core@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:nova-gpu@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:kunit-dev@
 googlegroups.com,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-pci@vger.kernel.org,m:alvin.sun@linux.dev,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alvin.sun@linux.dev,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvin.sun@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1DB3A747A91

During tyr debugfs development, a kernel NULL pointer dereference was
encountered after `rmmod tyr` while gnome-shell still held /dev/card1 open:

```
  [158827.868132] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  [158827.868918] Mem abort info:
  [158827.869177]   ESR = 0x0000000086000004
  [158827.869519]   EC = 0x21: IABT (current EL), IL = 32 bits
  [158827.870000]   SET = 0, FnV = 0
  [158827.870281]   EA = 0, S1PTW = 0
  [158827.870571]   FSC = 0x04: level 0 translation fault
  [158827.871043] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000108dec000
  [158827.871623] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
  [158827.872242] Internal error: Oops: 0000000086000004 [#1]  SMP
  [158827.872246] Modules linked in: tyr sunrpc snd_soc_simple_card rk805_pwrkey snd_soc_simple_card_utils rtw88_8822bu display_connector rtw88_usb rtw88_8822b snd_soc_rockchip_i2s_tdm snd_soc_hdmi_codec
  rtw88_core]
  [158827.872337] CPU: 4 UID: 1000 PID: 11276 Comm: gnome-s:disk$0 Tainted: G                 N  7.1.0-rc1+ #331 PREEMPT
  [158827.880534] Tainted: [N]=TEST
  [158827.880535] Hardware name: FriendlyElec NanoPi R6C/NanoPi R6C, BIOS v1.1 04/09/2025
  [158827.880538] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  [158827.880542] pc : 0x0
  [158827.880547] lr : _RNvNtCs257m05FHVbX_3tyr2vm8pt_unmap+0x8c/0x12c [tyr]
  [158827.880578] sp : ffff800083c236b0
  [158827.880579] x29: ffff800083c236d0 x28: ffff00013f8a0000 x27: 0000000000000000
  [158827.880585] x26: 000000000000007c x25: ffff000108e6ed80 x24: 0000000000401000
  [158827.880590] x23: 0000000000000000 x22: 0000000040000000 x21: 0000000000001000
  [158827.880595] x20: ffff00010f778138 x19: 0000000000400000 x18: 00000000ffffffff
  [158827.880600] x17: 000000040044ffff x16: 045000f2b5503510 x15: 0720072007200720
  [158827.880606] x14: 0720072007200720 x13: 0000000000401000 x12: 0000000000400000
  [158827.880611] x11: ffff800083c239d0 x10: ffff000141e4fd88 x9 : 0000000000000000
  [158827.880615] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000400000
  [158827.880620] x5 : ffff00013f8a0000 x4 : 0000000000000000 x3 : 0000000000000001
  [158827.880625] x2 : 0000000000001000 x1 : 0000000000400000 x0 : ffff00010f778138
  [158827.880630] Call trace:
  [158827.880632]  0x0 (P)
  [158827.880635]  _RNvXs6_NtCs257m05FHVbX_3tyr2vmNtB5_9GpuVmDataNtNtNtCsgmSOfgXi5CZ_6kernel3drm5gpuvm11DriverGpuVm13sm_step_unmap+0x3c/0x120 [tyr]
  [158827.891166]  _RNvMs4_NtNtNtCsgmSOfgXi5CZ_6kernel3drm5gpuvm6sm_opsINtB7_5GpuVmNtNtCs257m05FHVbX_3tyr2vm9GpuVmDataE13sm_step_unmapB13_+0x18/0x34 [tyr]
  [158827.891187]  op_unmap_cb+0x78/0xb0
  [158827.891196]  __drm_gpuvm_sm_unmap+0x18c/0x1b4
  [158827.891204]  drm_gpuvm_sm_unmap+0x38/0x4c
  [158827.891209]  _RNvMs5_NtCs257m05FHVbX_3tyr2vmNtB5_2Vm7exec_op+0x1cc/0x254 [tyr]
  [158827.894085]  _RNvMs5_NtCs257m05FHVbX_3tyr2vmNtB5_2Vm11unmap_range+0x124/0x188 [tyr]
  [158827.894105]  _RINvNtCs5hGKnPbRUFW_4core3ptr13drop_in_placeNtNtCs257m05FHVbX_3tyr3gem8KernelBoEBK_+0x44/0xd8 [tyr]
  [158827.894125]  _RINvNtCs5hGKnPbRUFW_4core3ptr13drop_in_placeINtNtNtCsgmSOfgXi5CZ_6kernel5alloc4kvec3VecNtNtCs257m05FHVbX_3tyr2fw7SectionNtNtBL_9allocator7KmallocEEB1r_+0x3c/0x100 [tyr]
  [158827.894147]  _RINvNtCs5hGKnPbRUFW_4core3ptr13drop_in_placeINtNtNtCsgmSOfgXi5CZ_6kernel4sync3arc3ArcNtNtCs257m05FHVbX_3tyr2fw8FirmwareEEB1p_+0x94/0x190 [tyr]
  [158827.894167]  _RNvMs4_NtNtCsgmSOfgXi5CZ_6kernel3drm6deviceINtB5_6DeviceNtNtCs257m05FHVbX_3tyr6driver12TyrDrmDriverE7releaseBW_+0x30/0x98 [tyr]
  [158827.899550]  drm_dev_put.part.0+0x88/0xc0
  [158827.899557]  drm_minor_release+0x18/0x28
  [158827.899562]  drm_release+0x144/0x170
  [158827.899567]  __fput+0xe4/0x30c
  [158827.899573]  ____fput+0x14/0x20
  [158827.899579]  task_work_run+0x7c/0xe8
  [158827.899586]  do_exit+0x2a8/0xac4
  [158827.899590]  do_group_exit+0x34/0x90
  [158827.899594]  get_signal+0xaac/0xabc
  [158827.899599]  arch_do_signal_or_restart+0x90/0x3e8
  [158827.899606]  exit_to_user_mode_loop+0x140/0x1d0
  [158827.899613]  el0_svc+0x2f4/0x2f8
  [158827.899620]  el0t_64_sync_handler+0xa0/0xe4
  [158827.899627]  el0t_64_sync+0x198/0x19c
  [158827.899632] ---[ end trace 0000000000000000 ]---
```

The root cause: `fops.owner` was `NULL` in Rust DRM drivers, so the kernel
never blocked module unloading while file descriptors were open. This leads to
use-after-free when drm_release (or other fops) is called on freed module code.

The series moves `THIS_MODULE` into the `ModuleMetadata` as a const, threads it
through `#[vtable]` to set `fops.owner` in DRM/miscdevice, and updates configfs
and rnull to use `this_module::<LocalModule>()`.

Assisted-by: opencode:glm-5.2
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
Changes in v8:
- Remove unused `crate::LocalModule` import in rnull configfs.
- Link to v7: https://lore.kernel.org/r/20260627-fix-fops-owner-v7-0-33cd3990edf0@linux.dev

Changes in v7:
- Use `crate::LocalModule` in `configfs_attrs!` and silence `clippy::crate_in_macro_def`, per Gary's review.
- Link to v6: https://lore.kernel.org/r/20260624-fix-fops-owner-v6-0-5295e333cb3e@linux.dev

Changes in v6:
- Update MAINTAINERS to cover the new `rust/kernel/module.rs`.
- Link to v5: https://lore.kernel.org/r/20260624-fix-fops-owner-v5-0-aa1cba242f05@linux.dev

Changes in v5:
- Add `#[inline]` to the `this_module()` helper.
- Fix configfs doc comment to reference `crate::LocalModule` instead of
  bare `LocalModule`.
- Link to v4: https://lore.kernel.org/r/20260623-fix-fops-owner-v4-0-0daf5f077d5c@linux.dev

Changes in v4:
- Move module-related types into a new `rust/kernel/module.rs`.
- Migrate binder from the `module!`-generated `THIS_MODULE` static to
  `this_module::<LocalModule>()`.
- Reorganise the series so that every commit builds independently, and
  drop the legacy `THIS_MODULE` static once all users are migrated.
- Link to v3: https://lore.kernel.org/r/20260622-fix-fops-owner-v3-0-49d45cb37032@linux.dev

Changes in v3:
- Renamed vtable associated type `ThisModule` to `OwnerModule`
- Added `this_module()` helper for ergonomic `THIS_MODULE` access
- Refined vtable macro implementation: one-liner detection and single `defined_items` set
- Reordered commits to place doctest fallback before vtable auto-insert
- Link to v2: https://lore.kernel.org/r/20260521-fix-fops-owner-v2-0-fd99079c5a04@linux.dev

Changes in v2:
- Merged old `static THIS_MODULE` and v1's `MODULE_PTR` into a single
  `ModuleMetadata::THIS_MODULE` const
- `#[vtable]` macro now auto-inserts `type ThisModule`, removing all per-driver
  manual patches from v1
- Added configfs & rnull usage site updates and doctest `LocalModule` fallback
- Link to v1: https://lore.kernel.org/r/20260519-fix-fops-owner-v1-0-2ded9830da14@linux.dev

---
Alvin Sun (10):
      rust: module: move module types into `module.rs`
      rust: module: add `THIS_MODULE` const to `ModuleMetadata` trait
      rust: doctest: add LocalModule fallback for #[vtable] ThisModule
      rust: macros: auto-insert OwnerModule in #[vtable]
      rust: drm: set fops.owner from driver module pointer
      rust: miscdevice: set fops.owner from driver module pointer
      rust: configfs: use `LocalModule` for `THIS_MODULE`
      rust: binder: use `LocalModule` for `THIS_MODULE`
      rust: macros: remove `THIS_MODULE` static from `module!`
      rust: module: update MAINTAINERS to cover module.rs

 MAINTAINERS                                |  2 +-
 drivers/android/binder/rust_binder_main.rs |  3 +-
 drivers/block/rnull/configfs.rs            |  5 +-
 rust/kernel/auxiliary.rs                   |  2 +-
 rust/kernel/configfs.rs                    |  9 ++--
 rust/kernel/drm/device.rs                  |  3 +-
 rust/kernel/drm/gem/mod.rs                 |  4 +-
 rust/kernel/i2c.rs                         |  2 +-
 rust/kernel/lib.rs                         | 75 +++-------------------------
 rust/kernel/miscdevice.rs                  |  4 +-
 rust/kernel/module.rs                      | 80 ++++++++++++++++++++++++++++++
 rust/kernel/net/phy.rs                     |  6 ++-
 rust/kernel/pci.rs                         |  2 +-
 rust/kernel/platform.rs                    |  2 +-
 rust/kernel/usb.rs                         |  2 +-
 rust/macros/lib.rs                         |  6 +++
 rust/macros/module.rs                      | 34 ++++++-------
 rust/macros/vtable.rs                      | 41 +++++++++++++--
 scripts/rustdoc_test_gen.rs                | 16 ++++++
 19 files changed, 189 insertions(+), 109 deletions(-)
---
base-commit: b7e5ac83cb16f7ffd11dc23736f84276602100ed
change-id: 20260519-fix-fops-owner-e3a77bb27c6c
prerequisite-change-id: 20260519-miscdev-use-format-9ab7e83b1c11:v3
prerequisite-patch-id: 405b334ff0d48ad350014f05a2321bdbaa025400
prerequisite-patch-id: 604b631c81d5423f4ebb2e12ba2d22e9ce371bfc
prerequisite-patch-id: cb550d94cefe01920e0d3ced2b2bcbecd76f3907
prerequisite-patch-id: 3bc830839742591460cb86d9472c04f4686dc600
prerequisite-patch-id: 571058244bc8c7088638d2e3225713011246c7e9
prerequisite-patch-id: 347c5a3c6dbef9832bfce8419fc23e6e08ba477f
prerequisite-patch-id: 3e202d988b56b88446f7535e90d3f00cf5f15701

Best regards,
-- 
Alvin Sun <alvin.sun@linux.dev>



