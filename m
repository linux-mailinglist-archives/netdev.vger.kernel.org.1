Return-Path: <netdev+bounces-52257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D5F7FE07C
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 20:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 050B6B210B1
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 19:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4D75EE78;
	Wed, 29 Nov 2023 19:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="UzEraR6U"
X-Original-To: netdev@vger.kernel.org
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2091.outbound.protection.outlook.com [40.107.122.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF60B12F;
	Wed, 29 Nov 2023 11:51:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/5KIlnpQXEloe/zINoaTja3eHQ3HL+TaebwtSZwhlOdxEE1liqv/NJrEWXoSi5WIsS1+pQoltHZDODMplp4FjUndtg1ydPB4OCtKCftdJzRXyMg/8UphJ4m+BVmXkQGIPDdJRR0H8zYUOuZN9ce8XQSs+NhkYIrnBomkqNXXG6265W7/rxvFOQAcltAZ6Oyjze8g78762AzdGsuAziXtDQPgvfU85of1tGK6SlaEmoeMwGlClczGijjEfXKkvQSHBFotF3izEdQuzjbsd9Zcd+c/P8y+qG6OR+cm7r1+BGBAkFUl0KwoK3THAZKKhG0b4STrvM1ALddG/OOehK3Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWas+LkLT23m2THUxnsP+3eiESrni88ERQIa4tvDsZ4=;
 b=CCmuLiZMU0DZptoyf7a0S4x9XkdQlrrvOi0ktcDQH0Mv+OMi53EvR7OO++ojW708891p2567v/vDpfFTBVRKcSkS1mZGrfz/+qSj12eaNQk2yoBp98hRcl/bJHScYT+ajGoKpFAD+25MNtwFG+at4FfOphi7P6+iNmkt/9/ptVtT834f7OhBOrrig8lXZLYNHTyeHVaLl2SpxpTdryS/CTSGEMquKUBmZhxooOxrK+VBsow49y1AuIiTg30Znep4hi6pPPTDhywQ3xAe0BHah2ZDeBrh4EtSMjhdsIjLbcShmmfE39sYmIO/pUCUXrIhmbanI92XZoZviQe4VIjDog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWas+LkLT23m2THUxnsP+3eiESrni88ERQIa4tvDsZ4=;
 b=UzEraR6UcfEqIlRDHCGGFygkgCIpEBBkvcCBVHgIKbPHT39IAUJ7NvQerRE+Ym4RIYJkUECattY4o1sFfPOKOxQsHitSrGwga6JK65zqvpK+z/UZ5zbBPX9unbC7gC5Hla86H5I5xRjDY/yxTPCNNh3iewOUIaN3xlPJ9VjA5NE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB6015.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2a4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 19:51:50 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ec07:aa7e:ffbc:ba47]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ec07:aa7e:ffbc:ba47%4]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 19:51:50 +0000
Date: Wed, 29 Nov 2023 19:51:45 +0000
From: Gary Guo <gary@garyguo.net>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 wedsonaf@gmail.com, aliceryhl@google.com, boqun.feng@gmail.com
Subject: Re: [PATCH net-next v8 1/4] rust: core abstractions for network PHY
 drivers
Message-ID: <20231129195145.69ff5cf6.gary@garyguo.net>
In-Reply-To: <20231123050412.1012252-2-fujita.tomonori@gmail.com>
References: <20231123050412.1012252-1-fujita.tomonori@gmail.com>
 <20231123050412.1012252-2-fujita.tomonori@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::20) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: 863c488f-471d-4fc7-9569-08dbf114a0db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I+IxAifIyvCz7Q/gZ0AaYyKv0z4bQPrCnGbHxLlD10e03CxuYwyG3JetIbwQuxa38MdkyXISOepdE2mNOSdPZJeWDpoEwKcybABXqDR7HV/34fmUYpTBwC16zjCpiQSZ+VNDknTug1+8TjiZpQfOnVDIRv1cpmI9ccNNkmwrtaBD5mxin9GMSWbKKKiWHWgwUsdkl9MZ4z4OBHvToD/mQffz+hSTxqBNoSnYv1lXdVHdbNMzOSfP1s2zG+YJPpaJBcGiB0FDfZAHvgqij+WbrqR5OFyVv2gcLDISUmAuxqenuGrsEnJtfYODvyukEDcx69zYaO1ubzxr7Qhqyayj7pLcuKCybnHwzT1s9abr/Uo6JNNpVqQcPm3LWJYoV39KcIPFvxFjko7h38u6o2NqC8HQaJ4kpPqijRqcErYh1PuwF+WYGf8/I4VJHaUxe+x+gkNz8iAM2O+BCiTzDYjEe/GYSRuweuGXf6bm4IY0TlFyqIIYLRRPeivWcevi4QWnSrsZdH7D4tmlvh4tzqY8pDpgFbZkZE1R1R5ToGb9dWF3QYSNlXfzQTSLtTTVChQB2UdbqwwxumT0R1xG4I0goW+8HK3LOlkJ1g2Tkgu5M2oz1VpmlJhpm9AAFlx2HhFE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39830400003)(136003)(376002)(396003)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(478600001)(6512007)(6486002)(2616005)(1076003)(6506007)(6666004)(83380400001)(7416002)(2906002)(5660300002)(41300700001)(6916009)(66476007)(66556008)(66946007)(8676002)(8936002)(316002)(4326008)(38100700002)(36756003)(86362001)(202311291699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ua+6udRjLQtLz4epOA4pz4JvJBDXbTttmtm94L5BTB4DHnqwxEueX7tJEbT+?=
 =?us-ascii?Q?IJNRcPhO5UZNmfhhk9+YDN4Dv0VnBLti3x4okgdReyOAJn8+7fluWVrtc2Yg?=
 =?us-ascii?Q?nmeIy6ZPnBWoNCZePOsLUZatRkCn1WG4oSkk+yDhl1xLsaD9dwPg5LLEQrVb?=
 =?us-ascii?Q?pdIY3Paz0QbOZNKzmRHz25RO/wckOH+ee3iQn8301Gxdv9u2BkyRccgebBp5?=
 =?us-ascii?Q?ZXFityISG8IeFl9UuzsvbB1mER1w2ncNegwrjPyIuOYRDVIkV7sSwcpyTWi0?=
 =?us-ascii?Q?aE3+M2Es6PCytz27sDkZNPVX059njyExCDGdQ5TfFiO6ncUl1muhrv9KDLFP?=
 =?us-ascii?Q?fhClkKV4ZJA2zmgtNPyl19wud7/hpSWRd0w6v2UpLiTKsK9Q+Y9W+gpHuGFD?=
 =?us-ascii?Q?u8Msn/OxpKc0fG7Creu41hb9pln4nSccZ96dFG3i8IzzTe1xp2LNe1f2VCqN?=
 =?us-ascii?Q?E6JI8P8OIOCMdNSxVFYBUCLAQHoEJFJa7PNoowPU0ejcLv4sumTh2eckk48+?=
 =?us-ascii?Q?yzzZetl+aUXYepjGFhm9gXv7bcwcoGthkhyRxLica5LRApIDGf6UE7IB+ydy?=
 =?us-ascii?Q?Zat3SadgxbZcDOw4BEMB6mhodmynz8I5jhofUz8h6EwOCJml256f1mbu9vN4?=
 =?us-ascii?Q?ojRnVzJCFu4AcF/PCl5/58XKfV0v2jGkXwjS0CLZsoiuCxoXBZ276zEwoVMG?=
 =?us-ascii?Q?ogwwbwd+BVIwA0CrXPXIREWx5sNVhdX9GupXTwmPmCkX6HILuuisewN1aYF4?=
 =?us-ascii?Q?rDpEQyGpEENAQjUBKyQerHnKymNi1pe4xWsaPu1O3ty3snbcij1mYiLnsmmu?=
 =?us-ascii?Q?+M7rY+EX+9xMGWMpxraU6nVGEhVMenbWDrF9xDjSnAEX3MTEqk2SHWS7Jtvz?=
 =?us-ascii?Q?CUCYoZgMHs0WMDwPHb47dOiYVWmLgQsVTjbsg4Ga8VdDHAsifpnKRhcpNA0S?=
 =?us-ascii?Q?eU8BfCM+Zx2VZftlVEKBasfCncMPXoSy78GdLWQ/HaLq9VT86ngSDhmN+q0d?=
 =?us-ascii?Q?ssr3tifkkRERXnDT0ahkaUhl4EJvPUOjkgo8lVDCn1hfYfRvg/muEf896Dtc?=
 =?us-ascii?Q?bVq7G/IF+lgnLmedrv0i3UUlwKngHTnfkl73/6VIMfK+/WCiBOA0aJKz4OF8?=
 =?us-ascii?Q?Yr6NDOpWsgVuyxongbSnhdufryxWY6wPi+E2nNXtuWGntIg32lO4QgTnt8Sg?=
 =?us-ascii?Q?X4kY0fpnERm6yw12ZstRoE8UYQsSCT4BK22FMekgl40ZdCvqFAkg9hr3cEEr?=
 =?us-ascii?Q?yEJS/dlkljNNMND/1tO3TgZ26IdEHnpG7qxw3jo6ky4nfTvAoJfbcGcb163O?=
 =?us-ascii?Q?j3rz+AFYVECU0G7A1Sv+gzI4kkrBYnUetcMkazZBX6dRfAqcSFPubcoDUM/o?=
 =?us-ascii?Q?ep+oYN1KRgKcLXqAPCbGJ3vxXTByIhmLcDm2LQ7haxRZ7yRGVkVPGf3q8ddx?=
 =?us-ascii?Q?mRV7qP6orfi2bVnZxiQwdgZpdzAoHD4Uz+nxU++Sqhl2PeYNbw4mC7nip7Db?=
 =?us-ascii?Q?rA9O4t2O+/8X2BMLuFFnrE+tpsEx5VE3rHTFBRplut0WdNMGNeJR4HYv+N03?=
 =?us-ascii?Q?urwUkwqWlxADw0IKJeN51ltMgQwU5S/bGZZ9ZmR6A/7+AurgFN4sV/LGAl8A?=
 =?us-ascii?Q?Q75ohKkcRwgnDZWKIOMsEvZfzS+D6/0tRxPMKqOpjPZ9?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 863c488f-471d-4fc7-9569-08dbf114a0db
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 19:51:50.5586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: waice1deavzXy3HA1sSv/244dbV2O3t4cOLELggAQC5cklJBgoMpmxFiR7HaWzutHijU05jatwyQeFXQFB2b+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6015

On Thu, 23 Nov 2023 14:04:09 +0900
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> +    /// Reads a given C22 PHY register.
> +    // This function reads a hardware register and updates the stats so takes `&mut self`.
> +    pub fn read(&mut self, regnum: u16) -> Result<u16> {
> +        let phydev = self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> +        // So an FFI call with a valid pointer.
> +        let ret = unsafe {
> +            bindings::mdiobus_read((*phydev).mdio.bus, (*phydev).mdio.addr, regnum.into())
> +        };
> +        if ret < 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(ret as u16)
> +        }
> +    }
> +
> +    /// Writes a given C22 PHY register.
> +    pub fn write(&mut self, regnum: u16, val: u16) -> Result {
> +        let phydev = self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> +        // So an FFI call with a valid pointer.
> +        to_result(unsafe {
> +            bindings::mdiobus_write((*phydev).mdio.bus, (*phydev).mdio.addr, regnum.into(), val)
> +        })
> +    }

`read` and `write` are not very distinctive names, especially when
`read_paged` exists.

Maybe `mdio_{read,write}`?

> +/// Defines certain other features this PHY supports (like interrupts).
> +///
> +/// These flag values are used in [`Driver::FLAGS`].
> +pub mod flags {
> +    /// PHY is internal.
> +    pub const IS_INTERNAL: u32 = bindings::PHY_IS_INTERNAL;
> +    /// PHY needs to be reset after the refclk is enabled.
> +    pub const RST_AFTER_CLK_EN: u32 = bindings::PHY_RST_AFTER_CLK_EN;
> +    /// Polling is used to detect PHY status changes.
> +    pub const POLL_CABLE_TEST: u32 = bindings::PHY_POLL_CABLE_TEST;
> +    /// Don't suspend.
> +    pub const ALWAYS_CALL_SUSPEND: u32 = bindings::PHY_ALWAYS_CALL_SUSPEND;
> +}
> +
> +/// An adapter for the registration of a PHY driver.
> +struct Adapter<T: Driver> {
> +    _p: PhantomData<T>,
> +}
> +
> +impl<T: Driver> Adapter<T> {
> +    /// # Safety
> +    ///
> +    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
> +    unsafe extern "C" fn soft_reset_callback(
> +        phydev: *mut bindings::phy_device,
> +    ) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: This callback is called only in contexts
> +            // where we hold `phy_device->lock`, so the accessors on
> +            // `Device` are okay to call.
> +            let dev = unsafe { Device::from_raw(phydev) };
> +            T::soft_reset(dev)?;

Usually we want type safety by to the callback typed access to the
device's driver-private data, rather than just give it an arbitrary
`Device`. Any reason not to similar things here?

> +            Ok(0)
> +        })
> +    }
> +}
> +

